Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CE1CD6E5E
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 07:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA9A9112ED8;
	Mon,  1 Jun 2026 07:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.b="D7w+Y2Sj";
	dkim-atps=neutral
Received: from mout-b-206.mailbox.org (mout-b-206.mailbox.org [195.10.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE76010E6FE;
 Sun, 31 May 2026 20:40:33 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-206.mailbox.org (Postfix) with ESMTPS id 4gT89p3xzWzB0JW;
 Sun, 31 May 2026 22:40:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1780260030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3PbhW0I5hTLPTG5PPW7WKo10HmrUXJCwd94aIaHC58c=;
 b=D7w+Y2Sja6RFumLMj3TOMtT34yuehZKFjzlMHNLvyp4yNpj2rZYmwRhQn9oGEkkIB+3Iov
 O5HVe8QhejkXyHu5UK5VNcLX2dT46jFO0PTopaeymV0jV79+T7BmG9f6Aw/HAf3eibMx+v
 FwwneZZnDLmFZZl09SuR4vxlH6Gja2oO6WszwKgE3RRy67Dc3DOAb1ZcqhT4lmjko3WMGN
 /iUD42nu0nsa9RZ75NH/N+R1ReW7a5j/FdP/pA7BIsNEQXmRmi5oOU+n1TH6mDZRTghejl
 VKvAD9B+oBhut6FnRsrjzscA/GYeveT4HkFJHGwnq8Lh+En6QbfWHA2YtAVMwA==
Message-ID: <79bea78e-fef7-4815-9574-eefaf166a11f@mandelbit.com>
Date: Sun, 31 May 2026 22:40:23 +0200
MIME-Version: 1.0
Subject: Re: [RFC] amdgpu: fix compressed buffer config routine waiting time
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Leung, Martin" <Martin.Leung@amd.com>,
 "Pinninti, Bhuvana Chandra" <BhuvanaChandra.Pinninti@amd.com>,
 "Ahmed, Muhammad" <Muhammad.Ahmed@amd.com>, "Chen, Karen"
 <Karen.Chen@amd.com>, "Chen, Leo" <Leo.Chen@amd.com>,
 "Khachatrian, Gaghik" <Gaghik.Khachatrian@amd.com>,
 "Li, Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "siqueira@igalia.com" <siqueira@igalia.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "airlied@gmail.com"
 <airlied@gmail.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
References: <20260519144509.2646680-1-antonio@mandelbit.com>
 <CH0PR12MB52849BD9E94D9290EFB51B528B002@CH0PR12MB5284.namprd12.prod.outlook.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <CH0PR12MB52849BD9E94D9290EFB51B528B002@CH0PR12MB5284.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 01 Jun 2026 07:27:00 +0000
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

On 19/05/2026 17:57, Pillai, Aurabindo wrote:
> AMD General
> 
> Hi Antonio,
> 
> Thanks for the patch. We'll add it to our weekly cycle for testing.

Hi there,

just checking if this RFC had a chance to be considered.
If there is anything I can do on my side, please let me know.

As of now the only option for many users is to patch the kernel 
manually, because otherwise the video is basically unstable.


Thanks a lot!
Best Regards,


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

