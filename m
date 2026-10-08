Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB407CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A63510FEEE;
	Fri,  9 Oct 2026 07:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=dawidwrobel.com header.i=@dawidwrobel.com header.b="mtS1b8yA";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9995610E150
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 21:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dawidwrobel.com;
 s=protonmail2; t=1791495565; x=1791754765;
 bh=xSjNxiodg+6yd07ntk91k2iFIK4a2SynGiN3plsLjO0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=mtS1b8yA53AqbOvYKBx3JH52RLhEuQ9k/qxtNwwYeknk9Q7E0scU1yDn17212pwXK
 SkWaJ/tsyNU5Df9pNVy1gzy5fEZDEeoPgHIi4tJBhzmtLilLEPULbIomgLpDcIGyrp
 tU8k6TnEFqPFH3xT9zW90mzSl1yHVvHuKBgXoaPOMJcb7d61jzVlHE/bxFRI4Z8hfa
 7bpUs06gSedfvkQbVSgOdiA5Dk4I95YLdmoRw0X0woMR2uMhyhk4KcbYvAMoZYlmya
 TOfeFA8dZTrT16zecCF5nhfDULi5eIretDZbuWu6l+DAMA7wW7mPsOZVC1I5YUIxP7
 e23Wh7IG2TmVQ==
Date: Thu, 08 Oct 2026 21:39:16 +0000
To: Jianhua Lu <lujianhua000@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
From: Dawid Wrobel <me@dawidwrobel.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/3] arm64: dts: qcom: add the Xiaomi Mi Pad 5 Pro 5G
Message-ID: <acd0ced0-533b-40e4-9514-1c616da6f9cf@dawidwrobel.com>
In-Reply-To: <20260908-sm8250-xiaomi-enuma-v3-0-0198c3bf954a@dawidwrobel.com>
References: <20260908-sm8250-xiaomi-enuma-v3-0-0198c3bf954a@dawidwrobel.com>
Feedback-ID: 173987960:user:proton
X-Pm-Message-ID: 71766e61f2fb574fd04937a409dd73e56ca88dc5
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 09 Oct 2026 07:17:39 +0000
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


On 8.09.2026 17:56, Dawid Wr=C3=B3bel via B4 Relay wrote:
> The Mi Pad 5 Pro 5G (enuma, 2021) is the modem-equipped variant of the
> Mi Pad 5 Pro (elish). The two boards share a design, so this describes
> enuma as sm8250-xiaomi-elish-common.dtsi plus the three things that
> differ: the board ID the bootloader matches on, the panel compatible and
> the WiFi board data variant.
>=20

Gentle ping.

The series has been on the list for a while now. Krzysztof's Acks are
on both binding patches, which remain unchanged since v1. Konrad's
Reviewed-by is carried on the DTS patch, with the two nits from his
review fixed in v3.

Anything left for me to do before this can be picked up, hopefully
still for 7.4?

--=20
With Kind Regards,
Dawid Wrobel


