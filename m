Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779BFCD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A6910E38C;
	Tue,  9 Jun 2026 16:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aC8wuJL6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C6B910E350;
 Tue,  9 Jun 2026 16:03:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 526EC6020B;
 Tue,  9 Jun 2026 16:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3C41F00893;
 Tue,  9 Jun 2026 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781021005;
 bh=4ebGrgngEkzamxgfnK/0XoDfIZTS3CWDxeVGgGrUT/E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=aC8wuJL6YMCMtrTSIZBSXZspSCOUwrB9WeVbxc5DLEkVudEvi5wKxFtaUjMwCJkLG
 HJwgosuvtHW54CJTecsMPHJhUinbtHzfwihA2OdfxEFJsUqYydxpXGGYf1p6jXtdBH
 I2Xc6ZQqZimGVeft+UGn52jmdET0IGrlskte+blKVdwog8RpKz2T2C3XBn0jrLEijl
 uy2621lvjIGCCdg8Vx3qEVcGSOsV9mEYGf5jBwCrGymQRrFl9WHSpiX/GRFNkXApMt
 b4p7AASGJsoDGS2as9GTPkjQVp3KF/7AkI+/aAb1PkhPjVUAtoxYzJBQ2pqJqyWz2u
 t6qagrSxlf7gg==
Message-ID: <4df73005-ac4f-4636-b18b-0c2f03004c2a@kernel.org>
Date: Tue, 9 Jun 2026 11:03:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Don't use UTS_RELEASE directly
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Kees Cook <kees@kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260428144704.1114562-2-u.kleine-koenig@baylibre.com>
 <aigx2xn-59FmGw63@monoceros>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aigx2xn-59FmGw63@monoceros>
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

On 6/9/26 10:32, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
> 
> On Tue, Apr 28, 2026 at 04:47:03PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
>> UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
>> uncommitted changes in the source tree or new commits). So when checking
>> if a patch introduces changes to the resulting binary each usage of
>> UTS_RELEASE is source of annoyance.
>>
>> Instead of using UTS_RELEASE directly use init_utsname()->release which
>> evaluates to the same string but with that a change of UTS_RELEASE
>> doesn't affect amdgpu_dev_coredump.o.
>>
>> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> 
> Is this patch still on someone's radar?
> 
> Best regards
> Uwe

Sorry it looks like it got missed.  Thanks for pinging.
I'll pick it up.
