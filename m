Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C69C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 20:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 048B110E225;
	Fri, 10 Jul 2026 20:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PjQVa5HZ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1CA610E225;
 Fri, 10 Jul 2026 20:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nWMCsn7SL/siBSwB6UFwJByxu9dJFWCvNa6O7mKClts=; b=PjQVa5HZ6snuoLqG0zl1RrpsCw
 lmhc62ysduDhxb5jFmj/T8iWuODj6/htZLn2UsW7tjb2rDF6dHa9/TrpBLjiB2H7yfAbcl5DfnFSv
 TcGIbQ17C51PQPiaL8POp+uRLfkc8Nyk118pTdH4pmMBJMd/Se26ElfeXESqEAyyjVutHSa5n9LuM
 qw8tCJPz7l+UGQ4lbh4GsQnCZJIFx279fwPkb9+3pvy1ijjnZCX6sOk1fQ19eJixU0zpLgVRjNmrR
 0Vla1DIImsjBvkaYNXcjZpZb3Cvf4jvN+i7znXE5CdjYIBVF5Yhuqs8QEcxumrC4bgp3e69JLTC8j
 /nm5RqHA==;
Received: from 179-125-92-221-dinamico.pombonet.net.br ([179.125.92.221]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wiHUM-00D82X-CH; Fri, 10 Jul 2026 22:06:22 +0200
Date: Fri, 10 Jul 2026 17:06:15 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 igt-dev@lists.freedesktop.org, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
Subject: Re: [PATCH i-g-t v2 7/7] tests/dmem_cgroups: add test for dmem.current
Message-ID: <alFQt8d8we7nFztu@quatroqueijos.cascardo.eti.br>
References: <20260702130108.1397444-1-cascardo@igalia.com>
 <20260702130108.1397444-8-cascardo@igalia.com>
 <20260707110740.5tublsdxxxsp222u@kamilkon-DESK.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707110740.5tublsdxxxsp222u@kamilkon-DESK.igk.intel.com>
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

On Tue, Jul 07, 2026 at 01:07:40PM +0200, Kamil Konieczny wrote:
> Hi Thadeu,
> On 2026-07-02 at 10:00:58 -0300, Thadeu Lima de Souza Cascardo wrote:
> > Based on the work of Thomas Hellström to test dmem.max eviction, add a test
> > for dmem.current usage after allocations and setting dmem.max.
> > 
> > Create a dmem cgroup, allocate close to capacity (or at most 4GiB), check
> > current usage is within a small slack of the expected allocation.  Then,
> > set max to a small value and check allocations and current usage are
> > limited to the max set.  Set max to 0, then check no allocations are
> > allowed and current usage is also within the slack.  After each allocation,
> > release memory and check current usage has gone down.
> > 
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > ---
> >  tests/dmem_cgroups.c | 245 +++++++++++++++++++++++++++++++++++++++++++
> 
> Why two tests? dmesm_cgropus and cgroups_dmem?
> Why not only one? This is confusing.
> 
> Regards,
> Kamil

Agreed. This is the result of cgroups_dmem being present in the original
patchset and the other test being Xe specific. The Xe specific test is now
replaced by what I initially called drv_dmem_cgroups, but I ended up
renaming dmem_cgroups.

I will merge them all into cgroups_dmem and send a v4.

Thanks.
Cascardo.
