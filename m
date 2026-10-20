Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35067606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=rmrD5bjs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6512810F175;
	Tue, 20 Oct 2026 19:29:34 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F2B10F175
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 19:29:28 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so31352165e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1792524566; x=1793129366; darn=lists.freedesktop.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=C/iSPX73nR7XVogkkTvvUPc6C5UsSw8Yeh0YEAvQaKg=;
 b=rmrD5bjsgSJjm6ZUWpGx9ZcgbWC66VHo21biCfRTivBJ8yBWDRjK6EKtiT4vBu+xNJ
 8O7HNVN1FXiyFN2yNIAgeUvXoKAYBv3Ltb1vQ9ySJtEigCsExhUTSuqpN7SOlCx2MjOx
 b8Dl0hfg9t838sh/UXsmpyCh/ry0k4z62mcguEIHOiMEhCxf1YPNJn+rwlM8JvI6cmPR
 s1Kv4/UPprrTLNK+9NBJ7fQCwiLRsEi99NpGXab4966ngfJZFOFAGxe7Mo2Cs1oUxm4N
 8b+jGk0Jr7hlTWE5tWGpEGI+XE4ipyVeCSgKI88A9VZfjJfBKM+f75Bl4Gw5Ch3gbCDJ
 Nn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792524566; x=1793129366;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=C/iSPX73nR7XVogkkTvvUPc6C5UsSw8Yeh0YEAvQaKg=;
 b=Y4gTDV5kcB0FYddllKBlmOoHoU5ZCFhg685tVRnWXyPAFobOXUSquOd36wnmi0lDkj
 eY0sHlIEpbj4yAf2A8fOqRYTXvNyZ6/61oO8kk0iE5jAHphjOKIRrBNSOs8GWJqzvHda
 RQcbgX6cEjSYca8SNnj/EU3dk1VJsA3tccD6yh49ad/EhHQ+8lJilS+3m9/cNFvMJztL
 XLtmuNN86VgrvjBqMvgBaClQKTtqz7y2PC1WX8otomHz7ROng5YR8435xzH77TF2/EMm
 ++HeF1DNu9IqBIH367Wia0N2hxV3xb7NZm+mMNXdXtZhFNUU1vRmXooPWwFa27/Sbkkc
 Pv7A==
X-Forwarded-Encrypted: i=1;
 AKwUvByVO4f1wUiBtNc0mNXa1DpUMHM8Rmgx5bA+ClFQ6AF6NSv1iFzJUGV4g81s+nBeL1Yd3L2pP26TgvY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLu/18gKyGJGIPsSUQamfqfaG2dV+UrkGMihU+DhfYUzFIvNrjW
 9Jjt39LKSu7gtxYc/Pj9BBoV/AN/djU3tnXuvz62ZQEGalRUmerxA8upS6FG+9S+ILs=
X-Gm-Gg: AYBFou3uv5KgSTx8sMrbp6H8sC4cmklC6i9vxyqwrf1Hf7ofZb3Tuh6AkDvDsq8CZnq
 z7FGCfTSeLwDOKRQbJqQvR/xbgWkPJJqhAK9/CWRgSnxXu4Q5agAPKDxif8N5sP5iQSeAQbEjlG
 DjnCfffQm1FqaZBE/+ClnCJpHQ2KpAPsZhMT6o3LTEqSXgEkHOOnYMpekPaYHqZNaB7A8DVIRi+
 RiOHCaHbDRN4GFa8v09kcOqIxz+qdMurffUDol5uazNXoxrXz/0sKvxnQPdKbULoFEJt9KdRM8+
 DiSUM0ktmQkk6iL+zLqO2HyZSC0AjsNnYua0swEadrZgwXFM4PxOj3sIu4qYeB7dilLPSX8Jclr
 lx6o4e9v+AI1IzsUMbBID+Oybi8PWKhStoGglBnWpNOAe4TtgA6pFFjfn7ZW3R/fNmN3wSF5GUK
 YqepN9Jm9CAxReTw9wmZTS6Udv8/VQJKN1aAAWw3bVMzQUjxU+bseEnCPO4ZE4OC+kCRCB+sAW9
 ZEo3aQ2Y6c=
X-Received: by 2002:a05:600c:190e:b0:4a1:90d7:88a8 with SMTP id
 5b1f17b1804b1-4a1d76106c0mr258091055e9.25.1792524566645; 
 Tue, 20 Oct 2026 12:29:26 -0700 (PDT)
Received: from localhost ([103.239.146.42]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36741e71eaesm1049611eec.26.2026.10.20.12.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:29:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 00:59:15 +0530
Message-Id: <DM9WX8LJQ2VD.3QUBHZYBWDBC2@fairphone.com>
Cc: "Douglas Anderson" <dianders@chromium.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <cros-qcom-dts-watchers@chromium.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>, "Jasper
 Korten" <jja2000@gmail.com>, "Federico Amedeo Izzo" <federico@izzo.pro>,
 "Luca Weiss" <luca@lucaweiss.eu>, "Hans de Goede"
 <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: Add Samsung Galaxy Book2 Go
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
 <20261012-book2go-v1-3-7188e7ea7a15@fairphone.com>
 <fb634f17-de56-4f43-b139-3d040a35f019@oss.qualcomm.com>
 <DM3MSNLF42BV.1UV490PXB0C07@fairphone.com>
 <emdm463llmoi6vsv3zmfjddqrfaf2iubdnydsqye2n6ui56oae@frsvj6el3zvq>
 <DM4DIJZOLJC0.2KAZET8VYUDY0@fairphone.com>
 <a69738f1-1c6a-4476-9c0c-8443650d1f6a@oss.qualcomm.com>
In-Reply-To: <a69738f1-1c6a-4476-9c0c-8443650d1f6a@oss.qualcomm.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 20, 2026 at 1:05 PM IST, Konrad Dybcio wrote:
> On 10/14/26 9:13 AM, Luca Weiss wrote:
>> On Wed Oct 14, 2026 at 3:28 AM CEST, Dmitry Baryshkov wrote:
>>> On Tue, Oct 13, 2026 at 12:17:05PM +0200, Luca Weiss wrote:
>>>> On Tue Oct 13, 2026 at 12:10 PM CEST, Konrad Dybcio wrote:
>>>>> On 10/12/26 8:11 PM, Luca Weiss wrote:
>>>>>> From: Jasper Korten <jja2000@gmail.com>
>
> [...]
>
>
>>>>> I'm assuming there's no pmic-glink on this device?
>>>>
>>>> I'm not quite sure yet how the USB stuff works. For sure from
>>>> observation, USB-C only works when stuff was plugged-in at boot time
>>>> (UEFI?), and charger also only supplies any power (but not actually
>>>> charging) when plugged in at boot time.
>>>
>>> This means that something is not 100% correct, for example, missing EC
>>> support.
>>=20
>> For sure some bits are missing. This laptop doesn't have an EC per-se,
>> it's got a "EMEC" - Emulated EC, where on Windows there's just a bunch
>> of drivers handling EC-like functionality.
>>=20
>> So e.g. already for battery, we just talk with the sbs-battery directly.
>> I assume this will be the case for the other components on this laptop
>> as well.
>
> I guess sweeping the i2c busses would be a good start. The other day

We have one list of I2C devices from ACPI description, and a different
list from i2cdetect. They overlap to a certain extent but also have
enough bits that differ for some reason.

> we got a contribution for a SM8550-based Samsung tablet which also
> didn't have pmic-glink, but used a SM5714 IC instead:

Interesting, will keep that in mind. Difficult to figure out what an I2C
chip is based on just the address and potentially basic register reads.
Downstream Linux devicetree would help where it's not just an obscure
"EMEC" device with a million I2C addresses in ACPI.

Regards
Luca

>
> https://lore.kernel.org/linux-arm-msm/f7ba4d5a-0e8c-417d-a1fd-5b5e392df71=
a@dxdmail.cc/
>
> Konrad


