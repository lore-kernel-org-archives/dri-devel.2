Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE096C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F45710E791;
	Wed, 19 Aug 2026 14:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="Uf5fwkSn";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9900C10E918
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1787150194; x=1787754994; i=markus.elfring@web.de;
 bh=Z45Dh8YUc3BGrrWwm7xYa5Sg8QQjx0AzwyoEFJ/r5rs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Uf5fwkSny3+Q0MQNbhLeOCl3cJUF+5caStpbD1L+aXhi+Te6Z6j26MycWVoXEpBr
 BZy5QMSL+Lo1l3CYKH8lyN3taAgVe+NVrEQ68aEMbTfEouots7LM2Th073ScJ3Jmu
 YOODGhlU1Ak0+3b5nDkX9hZS4OWgSjiA0BWkmsoPuDdbeaxgVtbuXjecvTq1Mq04S
 hm0KU6tZNE2rMVyb0/W0z95uiHh8xbI5/o76PloMkTHKDzuiUiDOONowf8Uz/nCfA
 du3vvK5Tj/E6gw1iT9JPEStMPzA7kQQnWiJZDf14kltG0cm0EsHmIGFHbphxlPdfu
 8PZxzgKGrNYT8Jd8Rw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mty5u-1wg7Qc2zC0-00xPNp; Wed, 19
 Aug 2026 16:36:34 +0200
Message-ID: <977d0549-c56c-4634-8f4f-ac9119fdf71f@web.de>
Date: Wed, 19 Aug 2026 16:36:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: 1298662399@qq.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 David Airlie <airlied@gmail.com>, Inki Dae <inki.dae@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Simona Vetter <simona@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
References: <tencent_989057BAD94EB58027BF7E9528F59A458608@qq.com>
Subject: Re: [PATCH] drm/exynos: fimd: fix clock leak on resume error path
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_989057BAD94EB58027BF7E9528F59A458608@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L15/ciHenYXp7vipUsF7bdN2ybdoDaGahcNoG/IabYKbYGd67MW
 Fq2YjiZOtwA4Q7QuCYjEVqpPbV1Uu45tWZvFMDr/Du3i1sAOn8Rv3ZcQkR7F6MmhoLcvDdY
 nt21oNjwa2GTzG5XGiNoRiqjQ4jB4RQr7gydeooAdXWMJiDMxav9V7Qox3sNpjjF5v2lgZ0
 z3sosZu844ZIpIohh6Q4Q==
UI-OutboundReport: notjunk:1;M01:P0:h3e9YzwAIcw=;bza8oQ3fT2czLSGb3tPHlvJczeI
 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
 13IKhIykaIQ=
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

=E2=80=A6
> Disable bus_clk before returning the error to keep the clock state
> balanced.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n145
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34

Regards,
Markus
