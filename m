Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6600FF588E1
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 15:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE6C510E698;
	Mon, 20 Apr 2026 15:10:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OLE7xbFZ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6F710E249;
 Mon, 20 Apr 2026 15:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1A2gZfmuuFzMfgpSkaTph9ulEpUua3g24igjYTyVDlc=; b=OLE7xbFZY3StImkpQ6yGjH9dK7
 uytiRiucDEmTX96vYeKtGbvSsN7OTADf6FiSwaiFppxE8ecWXzbHzvEguE/mc7wtQI3efus/RvUSO
 OjgaLqmdT+TBvGoLO6tmIPeVXBZq7VRKFbucGiC+ktqoo5g0slZtytMTgdyWIuxVuGRJnhOB0pVE/
 sFOYAEKR7KsQZyN67iKoxiGZwhAGVQl+7n3qAKS7weB1htWwWfWFAMZk2PtlzhtiKCrAIRUCEUPLa
 zasHcs7Zpf6L4Uq29eLsvs/Q5KIoIwdP9NIFjb7tIIcMDK027bY3Oht5RJ318qWrsPI4XxgpxrTnU
 A0pMyMiw==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wEqGB-001DeD-9d; Mon, 20 Apr 2026 17:10:03 +0200
Message-ID: <afa2404c-03b4-4293-aaa7-7ca2f8002f9f@igalia.com>
Date: Mon, 20 Apr 2026 12:09:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] VRR not detected on a DisplayPort monitor using an
 AMD GPU
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Ivan Sergeev <ivan8215145640@gmail.com>,
 Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, regressions@lists.linux.dev,
 mario.limonciello@amd.com, alex.hung@amd.com, daniel.wheeler@amd.com,
 rodrigo.siqueira@amd.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 sunpeng.li@amd.com, christian.koenig@amd.com, huangalex409@gmail.com,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>
References: <CAKx_Wg7_HBxuq5W4T_AmoFYJGQpa6TAS_Fx9SUzyy1itPmj5Bw@mail.gmail.com>
 <090d89a2-4f80-44ef-827c-6462d8948493@kernel.org>
 <DGJFVPAQJA15.378GMU7XZXLU@gmail.com> <DGJGDIRQWDG7.XHHKF6UQP0HG@gmail.com>
 <c70fe261-7fb0-4af5-b755-f02b193c8c5f@kernel.org>
 <DGJH30US2XMK.S2HOHR14LIW0@gmail.com>
 <bed447c7-07a3-46a8-9bcf-da352810883b@igalia.com>
 <DGK98QFUDRR2.1RCLDXI8XRBFR@gmail.com>
 <f0b79dd8-00e8-4352-b9ac-20ee6c114086@leemhuis.info>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <f0b79dd8-00e8-4352-b9ac-20ee6c114086@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 20/04/2026 11:48, Thorsten Leemhuis wrote:
> On 2/21/26 02:39, Ivan Sergeev wrote:
>> On Sat Feb 21, 2026 at 1:47 AM MSK, Melissa Wen wrote:
>>> Can you check if the attached patch resolves the issue?
>> The patch does resolve the issue!
> Melissa, was this ever resolved? I saw that you posted the patch Ivan
> tested as RFC here:
> https://lore.kernel.org/dri-devel/20260223203528.213275-1-mwen@igalia.com/
>
> But from the outside it looks like nothing happened since then, which
> made me wonder if this regression was ever resolved.
Hi Thorsten,

It wasn't. I didn't get the necessary ack...
Let me resume the discussion.

Melissa
>
> Ciao, Thorsten

