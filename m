Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB8CCD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 13:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B133510E112;
	Wed, 20 May 2026 13:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="d9ZAdOGF";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2978010E112
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1779283158; x=1779887958; i=markus.elfring@web.de;
 bh=RBnqLzWkwL7Iqz/H6b5xhX7BmdjV7bulM6AEuQcq4AY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=d9ZAdOGFmty+hCUHn+MDuy1oxNs07fGn9pCgSYOJvQYAAbyUK/+pVwpynUpbul9W
 bYUG7qeycUN23EJsW+a1v/NIFUcWPfrWGK4ANL2cMEoGjOK5+aTWMR2QpkL0iQP82
 Qhl67KNpwRQ4WRxfH3bkOIDkUYF85i0w0LNsTjI43QW0mc6HMwwqLdnzCF7SzO561
 p0ZMgX63xZ3SlZytfqetByAq/PvqHcmIVQ5Gd49PqrjMUTvS4i35lUlLACSwPauaK
 k32W6PlHvDMco/0VW8WP8E/4PWWhlHw0L4aXWwAAnCnwGuJWQ6nOGSwKmBkI7vBQu
 i76L8TSg8GCeBGokpA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWi9q-1wsJVG1wyG-00RS9k; Wed, 20
 May 2026 15:19:18 +0200
Message-ID: <77ca2dba-5e54-472e-becc-3d333ae6a123@web.de>
Date: Wed, 20 May 2026 15:19:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/loongson: rm unused member lsdc_device->gpu
To: Lu Yao <yaolu@kylinos.cn>, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>,
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>,
 Xi Ruoyao <xry111@xry111.site>
References: <788292607f1d81531f27b6fb616debc2d0ec1da1.camel@xry111.site>
 <20260520120520.293729-1-yaolu@kylinos.cn>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260520120520.293729-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:rhaSZIVwvde4MKwIBS4IX9Xpv0fC1E7QifAJXR7vCo4BK/lhsBk
 w8BbVjF1ao96JXH+GP3yCw7yhlY+Yt1/GFEP7ek0cYGA5pD3EZ+2+YwHMW1u6cLds3LxQ+H
 nN7iiBc96eAhLSZ0gXOlChsz2XejC65kKxUvufgpR0beAhFN2us6M5ifIRqD8A9al2rwigj
 nL6WXrWDzHJRk+6voNmBg==
UI-OutboundReport: notjunk:1;M01:P0:HSvtsC8aQ8M=;sInpn74xzfvMfC94OKxC1yolJW9
 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
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

> lsdc_device->gpu never be used.
> And there has a pci_dev refcount leak in lsdc_get_dedicated_vram() for
> calling pci_get_domain_bus_and_slot().
Would there be a need to split adjustments into separate update steps?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.1-rc4#n81

Is the change description still improvable?

Regards,
Markus
