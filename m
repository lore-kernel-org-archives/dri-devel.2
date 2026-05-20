Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86885CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 09:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E859510E10C;
	Wed, 20 May 2026 09:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="gD/VLnWt";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34E210E10C
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1779267944; x=1779872744; i=markus.elfring@web.de;
 bh=OPswkR9zpEjEMxTngQB+ClVh+MwqnUdMDnFhkMHFVeY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gD/VLnWttQjqgR48Kqu4vAs+yVW48jSOT4cRiYKJE4sabdF8rTORuv/PmimBsHK4
 vrRl6wjOHOt2jm+ifvvHPEvOHwmEKSO1jBAJa75i7J3ajmTArtAan1xwDyBdz6l8L
 KldCsd80zG77t+RibuS+JM2Lwb0GsvEVpw03wrpoxfBj8+PdzEeqzkePkxznI0yAZ
 Ed9I5nQlzSRXQQ9rUmcWkP2ypaEVX2Kcr/qSnt/DyRkdM2bw/oVRkSMvJZ+qofDzj
 IlGd+nFzG/6spCpmBJYmLcJ+m7jjAcBAkliUV6y3XKtWB8CtfV+xBS0bdD6gFakSX
 n3aoVZ3YrLarQl5hjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKuKF-1wdZkj2odZ-00Nv0h; Wed, 20
 May 2026 11:05:44 +0200
Message-ID: <6ccfe40e-fe4b-4a05-9ab1-82cdfcaa0811@web.de>
Date: Wed, 20 May 2026 11:05:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/loongson: fix pci_dev refcount leak in
 lsdc_get_dedicated_vram()
To: Lu Yao <yaolu@kylinos.cn>, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>,
 Xi Ruoyao <xry111@xry111.site>
References: <8ba844ab-9851-4045-a4e8-a96e6d1511e2@web.de>
 <20260520014721.32696-1-yaolu@kylinos.cn>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260520014721.32696-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:B9GGLD8FanBL1jfXYkMD4ceR3T34Z2QkSI5IpwLGQ4skrQ7o1JK
 6CRsR54XHB1qFptooNcQJ6Ob4IQmodzvcSLkqk1sCgkrCSMAvFJaBRUmTp4/ZQ+qv2drUo+
 Na9tF0zSB/l3whbAMqXWPE1B8x2L2F9fb55mjkNvUQwYGSiaV9f9ckULISbpr7gLlKU+APG
 gaiQ2B8AwdRc96yZuFfFg==
UI-OutboundReport: notjunk:1;M01:P0:nLovPW5Bxfg=;FRkFTw8xxVPmvdEKRTiSCb/PLqO
 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
 CgJ93M1ruoAS1cMd7Y2mjq0k1cj+FEn8vvoM=
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

> Need to call pci_dev_put() after pci_get_domain_bus_and_slot().

Can development interests occasionally grow also for further patch requirements?

* Usage of imperative mood

* Reference counting

* Completion of exception handling

* Related tags
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?h=v7.1-rc4#n34


Regards,
Markus
