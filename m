Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDA6C61DBC
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F40E210E225;
	Tue, 25 Aug 2026 16:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ofptO+yL";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F1DB10E225
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 16:33:13 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 294074E413AC;
 Tue, 25 Aug 2026 16:33:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F2633604C4;
 Tue, 25 Aug 2026 16:33:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C31F811C7A6C4; 
 Tue, 25 Aug 2026 18:33:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787675587; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xx5O1KxBaZ7/74bIcM8o/FOaog4ETe2+UK5KNLE9Auw=;
 b=ofptO+yLgLGhxJ5X2g0+twP9ifu5S2qOjWu9gkHDvKJ21xekzSejSXxq37JRTxv9aZertK
 XEhf13CNfKjjvflsT893Uyz0Z3Gm9ekfVj377JBbnA2o7KeHIgklf/QciafrqNEUi6Noti
 q1GBaOUJ3nDjkrvaD+Rcghi1kOiYbCK7HitKPFkdtiz74gbLTSUIUNcnb7FK1G+tbSkTMJ
 uirJF1IeS5Spt0djbxbb+3zJz3CSs4JGAGQhk0IHBzoJixBxH5n8TJyzMdIyuB94/DO5Hr
 ygm9bEo6AksqSoxQUnBzAO5s3N3qopi2gWjycAxQ54WbjP9IAjYvzkPz74XQ1w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 18:32:58 +0200
Message-Id: <DKY63R86UGQC.2JYVA26EV6Y0O@bootlin.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Osama Abdelkader"
 <osama.abdelkader@gmail.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Jessica Zhang" <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jerry Han"
 <hanxu5@huaqin.corp-partner.google.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 1/6] drm/panel: Use devm_mipi_dsi_attach in BOE panels
X-Mailer: aerc 0.22.0
References: <20260812130429.16850-1-osama.abdelkader@gmail.com>
 <DKY5E1PJ172I.2LYOZZT775PE9@bootlin.com>
In-Reply-To: <DKY5E1PJ172I.2LYOZZT775PE9@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3
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

On Tue Aug 25, 2026 at 5:59 PM CEST, Luca Ceresoli wrote:
> On Wed Aug 12, 2026 at 3:04 PM CEST, Osama Abdelkader wrote:
>> Use the managed MIPI DSI attach helper in BOE panel drivers and drop the
>> corresponding manual detach calls from remove paths.
>>
>> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
>
> Please, next time use proper tools to send your series ina single thread
> with a cover letter. This v3 is made of 6 e-mails in 6 separate threads,
> which is very annoying to handle.

Ah, this comment was about v4. v3 is correctly threaded. Sorry about the
mess.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
