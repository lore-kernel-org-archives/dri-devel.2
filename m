Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51595CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B2910F2C6;
	Thu, 25 Jun 2026 13:25:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WeysAnzO";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 103BB10F2CE;
 Thu, 25 Jun 2026 13:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZhSTsKEqP6hhtF0Rymr3DME6a07dkDUYrzylnv1XxG8=; b=WeysAnzOduioc9tUdPr9SEjsBh
 osUbX3DUqMcCAWzhJjeG5xFcNAVx8p9RI2X92EIdRBCgOfAoO4oBA9s4CkbL2YQm8bwGVjevivOuf
 RQD2BX+5lF0iI5yxAzQVO8bshTYrPSD10ssSQ0eeTeVoSxo5q4rk3c85UArdJkFxeAV2v1/L9cAH1
 8Hrx+Et3sR6MQUPFuAKsBS7iKDRGUN9ymkwSH5EWhgUB3bzYL3Bo/WsRhEv4G/apKUcLnCxDJJFE8
 bjLmxOFL/nCYI8Z5WcpF7DIHq0+Sqssz1i2hxyE8RVIEk9A8bLbsncgPgnsrUm3rKyy5IK69ydYI2
 PolOxVjA==;
Received: from 179-125-64-254-dinamico.pombonet.net.br ([179.125.64.254]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wck4j-00548a-Ap; Thu, 25 Jun 2026 15:25:02 +0200
Date: Thu, 25 Jun 2026 10:22:02 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>,
 Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] [PATCH v6 0/6] Add reclaim to the dmem cgroup
 controller
Message-ID: <aj0rembs3CGy0ZMX@quatroqueijos.cascardo.eti.br>
References: <20260611173301.17473-1-thomas.hellstrom@linux.intel.com>
 <ajBJU-Jp2QVy14qt@slm.duckdns.org>
 <ajBLAsNoKesXmFcs@slm.duckdns.org>
 <ajlUPmaMsa2gxOLg@quatroqueijos.cascardo.eti.br>
 <ajzxLABtnWym81Dp@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajzxLABtnWym81Dp@localhost.localdomain>
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

On Thu, Jun 25, 2026 at 11:19:19AM +0200, Michal Koutný wrote:
> On Mon, Jun 22, 2026 at 12:26:54PM -0300, Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > As far as I understood the patchset, it doesn't fail the write if it fails
> > to reclaim. It sets the new max, then, if the write is blocking, starts
> > reclaim and eventually returns after multiple attempts. But it still
> > returns success.
> > 
> > So I believe this is behaving as you would expect.
> 
> I was alarmed by the EBUSY mention similarly to Tejun but then I
> couldn't find it in pre-patch (840ef6c78e6a2) nor in patched (v5) code.
> Please make sure the EBUSY return behavior is not introduced
> (essentially match memory.max behavior) and that the accompanying
> message refers up to date code ;-)
> 
> Michal

I think this is a reference to the fact that right now writing to dmem.max
calls page_counter_set_max, which will return -EBUSY and fail to change the
max value. It is just that we are not returning that error today to
userspace (a fix I have submitted back in April).

So, this patchset by Thomas is setting max, and, then, if it is a blocking
write, tries to evict on a best-effort basis, and returns success after a
few attempts, still setting max to the written value.

Cascardo.
