Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8341AC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 20:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D13BD10F425;
	Thu, 13 Aug 2026 20:14:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="aTwZwclK";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-77.mta1.migadu.com [95.215.58.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A5BB10F425
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 20:14:30 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=1hXNPiyXhri9UZHMDO1sGuY4VCMVwnJ7/BYt48XW8FI=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786652068; v=1; x=1787256868;
 b=aTwZwclK7Tse+/T6C3ZJdW62uOlD5CKxJ+6FP2PUk8XQBIb/mUjB1RtW8G5Tepiykgkv2Coh
 urwyeoUOnf3y4rzhOxhdObSHW7x/JWCFAECokaKzPPL1HBNe6DhNshwevnQj7oBC93Gb+B/ICXZ
 RA5bKYj4yh6hkDKfDT4nau40YI9TO9BfFH9/P7B1A7ZSFXhulql8tv+IvwH6J+ZkNM8gSTLbZ2q
 Ccx1h86emPZyIRz6CsVIol4nj/2WHTcEWGHCqPeulMr3nWIRyMlIymsnv5hI/WVA1uLAICY+JSG
 NcPI+f2y2AyQuwXQsNkvGLPbf2dYL7+BnIIlHKNusA3vg==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id dc51fc7944878c17;
 Thu, 13 Aug 2026 20:14:18 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Alex Deucher <alexdeucher@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: taimuraz@kaitmazov.com, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Max Zhen <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
Subject: Re: [PATCH v2 0/5] accel/amdxdna: honour the SYNC_BO range
Date: Thu, 13 Aug 2026 23:14:16 +0300
Message-ID: <20260813201416.158728-1-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_PZxoBKqsg6i0eN-wkOBF3UrEZ2cVkMAtgzVD7Kv6ZSDA@mail.gmail.com>
References: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
 <a505f9e5-b416-43e9-934d-c5c29b8a70e9@amd.com>
 <9420bbe5-46a3-84be-eae8-596bc42bddac@amd.com>
 <CADnq5_OR5bFoFJoMoj9bc2_f47TunVnDFrmA_2tT+0k-DZk_jw@mail.gmail.com>
 <20260813195059.149991-1-taimuraz@kaitmazov.com>
 <CADnq5_PZxoBKqsg6i0eN-wkOBF3UrEZ2cVkMAtgzVD7Kv6ZSDA@mail.gmail.com>
MIME-Version: 1.0
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

On 8/13/26 23:06, Alex Deucher wrote:
> I wonder if there is some device config option to enable snooped vs.
> non-snooped DMAs?

I tried the PCIe one. Clearing Enable No Snoop in DevCtl, with lspci then showing NoSnoop-, changes nothing: same 20 out of 20 stale both ways. So the array either isn't carrying the attribute or isn't looking at it.

Taimuraz
