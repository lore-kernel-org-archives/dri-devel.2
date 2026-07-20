Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13190C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72AC110E183;
	Mon, 20 Jul 2026 11:28:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="X53uQ2PJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E2010E183
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=yWng1MKHiarnntV3Qy063tcQi/vNskv89+pIZiz4e64=; b=X53uQ2PJbTAS+LxcaPqvJzeUeQ
 cMsAJnR+AMadOqSwBbJMjFeemfWk7Gv+dGpjVfl+yR2qiYHeJng++alOYCYjiJJNgm/UwlYcKAKZk
 cZmuAlvoBkcifsYwDVcFmOor9EEQTxZauE6jMffD9lgusaA5A5M+A8NagXCbGJ4kzZyLTIll1nnna
 31AeFvUnvD8ALwABAQ20aEdviV+wZNfhaSn2wz7b6CetnjLZYOOROHHKJqCFBmvy7el9jrEXvU3QR
 djFmibXfDvZHhW+YmFPa9jX29soyCXpieUW9mKkRjU++exNezDBO5f1vNwmWvShOtw+Z6F5OMJxCz
 LQaQ6/oQ==;
Received: from [179.118.191.219] (helo=[192.168.15.100])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wlmAj-0011wH-BX; Mon, 20 Jul 2026 13:28:33 +0200
Message-ID: <62261b91-7976-4556-9cd9-eb100d72547d@igalia.com>
Date: Mon, 20 Jul 2026 08:28:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_mailmap=3A_Update_Ma=C3=ADra_Canal=27s_?=
 =?UTF-8?Q?email_address?=
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <maira.canal@usp.br>
Cc: dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, Melissa Wen <mwen@igalia.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>
References: <20260717111559.2759217-1-maira.canal@usp.br>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20260717111559.2759217-1-maira.canal@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Em 17/07/2026 08:14, Maíra Canal escreveu:
> My university email will cease to exist in the next few days, so map it
> to a personal email address.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
Reviewed-by: André Almeida <andrealmeid@igalia.com>
