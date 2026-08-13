Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611DCC5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CEAA10F454;
	Thu, 13 Aug 2026 17:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z8OfQFYL";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8610E10F454
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 17:28:55 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso1161565b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786642135; x=1787246935; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3QAmNckJusENFi3b8PAoUfCMcO2O6+LVywV/5dZdBLk=;
 b=Z8OfQFYLv1W6p8/AmlLYVOyBESciDt5mhP/1ossUy7pm3pwXi7uRSIJA9ktY1tSTnI
 KViIvn/wh3yyeO/GUPA8P0sVeAcmLzUL2CwJnP4I+0102I3WE3NyQX/9xhGZWmLlc5Be
 MBoyGDiG6+t4nsTsnCVfOcdqpIc+Br032oVnbKZut+kz50O7dujishz2Wssaz2pQJw5Q
 fciLTwI7UjGcnn7oBOMvBfBgUIk/y1LlBKjQ0vkPs1M1kk4lU+Z+trlwzwp1b9p1BgDz
 RPhWXO8AdX8I15pIrLzhjH+4IUanR5ryQTkDAzZW80iuSix0c/SZJg//jsSrBhyorTa4
 T/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786642135; x=1787246935;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3QAmNckJusENFi3b8PAoUfCMcO2O6+LVywV/5dZdBLk=;
 b=CHn63bqdzpBxQfBYKxdYnvaGAbANjqr2a/qm6+oGJN4tKenfDK0SLNVMddiAYbbj/1
 3PKPqadp9bK1xQ3jkC/0JYm5kyO0nvF8WFg+ewhCwT7Yyj6NhpNaId05/BTkZY8wABlQ
 MXrtaq9ZJPlRXIKlVhUwN/Pki7tVmJIWBWKO0TvwoF5KWWNPR5NF0mcW6E2n2Z0QxcfM
 La+Q1hlt30xdVDm68PIxd944yekILxHjlxWALsQiUwGbP58i9XuxDFEBVZE2jpwPI0OE
 BOf8ouv8NLtOk7jCD3SIzVSpguFc7SDM8SWMCAhmHMzhmnEKJKERgarE3yMWx1Vil2so
 XAcg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoY9Nbt8x8KcIQ86t4D7TiYDk4ZlFZ1M8EohXQJIH2TcLPrfERbRfrS9I1UaDLKuPcg6bx85yco/O8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvWsvLmQEIqeM/eR3+svZhT6PQNy8ohN+HoRHBDo5ali+oaB1v
 kJrOR9FKnqI8fo2B9QUCEghBtoo4NAVAtjR+FVvng5zDWQCwbZjU/A8=
X-Gm-Gg: AR+sD12LFCRbHFET5lYTJOJTYXS8ldMjYhWjYMniFA/oes2wG93HLRJCGnPEuH8hLVL
 Pos5KFaKxPnn0a4ANuX4LvfMK612gMcZrKhsGz0pSAlfD27j0ZhvY3OUcW4dDsZIVx4mqHWy1AP
 Nve3g8ob+xJPVijqgdVZ3LyhI7mTsICQB6q4N9KjJrP1uD7qlYdnqHsOwpJPj5qmfjm8p7O5uPJ
 0hqeZoXnF3ySKoHv6bVR4PKcMHVOqNJSv8GV8u6MbRv07N/ggcBFUdaf9hjsTeEbeFbQC/NYtNb
 u12HRx4eylM5wWuNr3giZGvXkcRXF7pnSXuYOPXHfhsdagXDy1J1gcB15p6gRwq+w61kCQUrF1L
 msOceHjeHvPAdmVVwBgCds72V1dawGMPRkdxIDxkFQzWIB0XpLLO3B7cRN1fYStCHbTfYAdtRps
 bx79qsq/JKhZiZlUsN2EqCGWv95cjEpFylAa/s4m5eGGEmUh2JLQ1OoHUocKFNUXaBFj0WnUS0g
 FxmhOyhayaKvv98ILpQqCp8
X-Received: by 2002:a05:6a00:44ce:b0:848:6b43:35dc with SMTP id
 d2e1a72fcca58-84fc767caa3mr8813674b3a.35.1786642134845; 
 Thu, 13 Aug 2026 10:28:54 -0700 (PDT)
Received: from localhost ([186.158.238.108]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc5a1bcaasm1251435b3a.29.2026.08.13.10.28.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 10:28:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 14:28:48 -0300
Message-Id: <DKNZRYZZVSEA.I0LC7DRPXFK9@gmail.com>
Cc: "David Airlie" <airlied@gmail.com>, "Jori Koolstra"
 <jkoolstra@xs4all.nl>, "Conor Dooley" <conor+dt@kernel.org>, "Brigham
 Campbell" <me@brighamcampbell.com>, <linux-kernel-mentees@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Maxime Ripard" <mripard@kernel.org>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: display: add Chipwealth CH1115 OLED
 controller
From: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
X-Mailer: aerc 0.20.0
References: <cover.1786110720.git.nico.antinori.7@gmail.com>
 <cf9b02d618db4eca88e2d32b4bf779011fcd550d.1786110720.git.nico.antinori.7@gmail.com>
 <178611771198.882916.15330377894023589629.robh@kernel.org>
In-Reply-To: <178611771198.882916.15330377894023589629.robh@kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hello Rob,

On Fri Aug 7, 2026 at 12:48 PM -03, Rob Herring (Arm) wrote:
>
> On Fri, 07 Aug 2026 11:19:50 -0300, Nicol=C3=A1s Antinori wrote:
>> Chipwealth CH1115 is a controller for monochrome dot matrix OLED panels.
>>=20
>> Signed-off-by: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>
>> ---
>>  .../bindings/display/chipwealth,ch1115.yaml   | 73 +++++++++++++++++++
>>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>>  2 files changed, 75 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/chipwealth=
,ch1115.yaml
>>=20
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/display/chipwealth,ch1115.example.dtb: =
display@3c (chipwealth,ch1115): 'contrast', 'first-page' do not match any o=
f the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/display/chipwealth,ch1115=
.yaml
> Documentation/devicetree/bindings/display/chipwealth,ch1115.example.dtb: =
display@3c (chipwealth,ch1115): contrast: b'\x00\x00\x00\x7f' is not of typ=
e 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml
> Documentation/devicetree/bindings/display/chipwealth,ch1115.example.dtb: =
display@3c (chipwealth,ch1115): first-page: b'\x00\x00\x00\x01' is not of t=
ype 'object', 'integer', 'array', 'boolean', 'null'
> 	from schema $id: http://devicetree.org/schemas/dt-core.yaml
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.kernel.org/project/devicetree/patch/cf9b02d618db4ec=
a88e2d32b4bf779011fcd550d.1786110720.git.nico.antinori.7@gmail.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.

The patch is based in 7.2-rc6, I am going to rebase it to rc1 in v2
(or wait until rc1 of 7.3, depending on how much it takes me to solve=20
some observations found by sashiko).

Thank you for the clarifications!

