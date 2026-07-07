Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CF8C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 21:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE4010E0CD;
	Tue,  7 Jul 2026 21:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=shazbot.org header.i=@shazbot.org header.b="XdwZYmB9";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y3TIAVti";
	dkim-atps=neutral
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3400510E0CD
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 21:16:27 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DD2CA7A0109;
 Tue,  7 Jul 2026 17:16:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 07 Jul 2026 17:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1783458985;
 x=1783545385; bh=vkTzXFusKTTIzAQzapZbpKsgu5UXxCg9u56mTBnUn7E=; b=
 XdwZYmB9Wj4oqWvOIK7bccnJslD6HR8FgaMBfQWZYWFlT8Z+vBsobTe42nYcWuNT
 +zew7RpbwujCzxlPa/K+9CtdvsLHI0ctWZbEXCzCkMvjD7cEZTlY4DKEe2oJsBUq
 ehU7OuLiOckXV+d4s7PX8BBMjP0w/KzYp+y16Eu+0L20qbFDE9O6AjZ9U5wxJAcG
 SYf/qx8c8cXSd4ji5TAVU4kYWkld7UVzo8VrCvFTkMohgtd6SQiHabu4C5zJYzmj
 C2acCPSiQ6W3TvfQTVnpq4v1nETBDUJ1HoTZoPKUbONgVMizM6ueeYoJbPwYkQaY
 IMBGexgUoF09FW67PBZw+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783458985; x=
 1783545385; bh=vkTzXFusKTTIzAQzapZbpKsgu5UXxCg9u56mTBnUn7E=; b=Y
 3TIAVtivpTUnsA+Mi5eq5BacL2+3GBZIO595ClYpUhuD1u6wR90XAloOwCYGUmez
 OskdUD2E5iUR/R/NTAuE7IbFYmTl2bgCOxQnTzQg5tJQ9zJEdHaRplFzDJie15TT
 jcZ3eu4BsafddtPhge6Hui5x3yXu49noXegJza2H9IZwf6Nct/7f93lLTTsBWsy9
 thJKxdx1709dmZfP2wYpG+Oh3kTQYCEIA1X0KHKaSMRfggD7L48qwehKpG/rGYSP
 V36JWk1GmrFwdXj+sdlFJRItNyAxtH1Yqk82z4F4e8nzzIbjpSczsdGMrPvruzod
 8mo67cTe+SZJZ21BNDLWA==
X-ME-Sender: <xms:qGxNaiqsjFChoxPMCCyTFgtWVk59FW8Tj_bPLLiwwekTSBLycVJfLA>
 <xme:qGxNasXZ7d3K94TrK5Hqd-3_KqmcGGHNUgBnDM6KS-Fh80B__4oSHpa-2NLhxHVWX
 VlWyMIrNfd3S6GKpdikEZJeQCvdOoaklUaRye6B3Mg-0xLfQS2cnw>
X-ME-Received: <xmr:qGxNah4Q0WO-OL2gA9k_5tAKz4mVcqOEQK0vMrpOq-SY9ibT9UZkQnU_rFI>
X-ME-Proxy-Cause: dmFkZTGZWM0TZAYrez3OUUVryhpKd4yBz4AC3t1m3FkOUK7rQ5mGJ4wrt4utdwOVYPjpQp
 vzQtgJbhl8rO/x/CT9lk4Zp3f4iiNmlVyK9JAdRnk+zJK0ETjdKCobP3R9NLjCnoEjfNAv
 txL/7RwaZE/cmZiUsnkpcFbWnkixRDRAG9X+ot3yl5IutpYx6Jdahs0nXCnd4lBTXrjGX/
 QN9h2Lvfl1ViCbBWWKbgcHme930j7OPe4HLWznK0DBqLyQX0WvphwSbm+uDQ8ztc5iBuTi
 +FV3waBa2MmWtUt0rU/S1hteG77+Mx6/10h/wbTQKXc41WSIOLVnSrvU4tkxSuwq2S09ig
 tWNR7X7iLIx00DcIlNZrohC8zkRj7NAdZtje+7b9qpULkOfaliC1QJilJB/V+S4w1GzLSN
 ipP6jo5pnbodPKAvNK2guRF7NeGQ8dabSCInLGizMzmO74o37/mas7XpniWxhmnGjNEusz
 +TMTFHHYYyCXNO/5ssMxGsxLoA+O/0gJB95eMgKsC8Gv+jOPFhAvxuvYbKuiXKlZ92SHut
 /Ry0n610i7H7Ougj/OfoRPKK41qb7/q+1BIWFVhXOAXDzwcVDwP4Je/OOiS6PWW3J5Q9et
 Tgb/hc3n8cF/fPpQLhwhj/AI+cojyxehy42/j85EzmTuV/uvMLHOERPoKljw
X-ME-Proxy: <xmx:qGxNai0YUQKckzrnWgqMvctSdfFOW7SlApkhvhKvdILX6E9_yle2RA>
 <xmx:qGxNag_5eHBCfXMhWqA9g-yhtlg2eDA3EQzPl-69iyFuq1zFTNulpQ>
 <xmx:qGxNajuW9aDdn3mdSBIA-9HdtfcU1HNFoICIN5LlnG19xbX3HA4mMA>
 <xmx:qGxNaspLtqRXcjTGjtK42yqtwdLxJgghDB44m-4kK_bj4Utvvv0saw>
 <xmx:qWxNar8-nB_4JdGiKT5Nlb8zOgYid1ncsMBRLiw0IAUZUBYTLIkJGT0O>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 17:16:23 -0400 (EDT)
Date: Tue, 7 Jul 2026 15:16:21 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Logan
 Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>, Pranjal
 Shrivastava <praan@google.com>, Mahmoud Adam <mngyadam@amazon.de>, David
 Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal
 <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v4 00/10] vfio/pci: Add mmap() for DMABUFs
Message-ID: <20260707151621.6bb023d0@shazbot.org>
In-Reply-To: <20260701171245.90111-1-matt@ozlabs.org>
References: <20260701171245.90111-1-matt@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed,  1 Jul 2026 18:12:12 +0100
Matt Evans <matt@ozlabs.org> wrote:
> 
> This is based on v7.1.

Hi Matt,

This needs to be rebased.  Sashiko has failed to apply every version of
this series since the v1 posting.  It's straightforward to rebase, but
there are some subtle gotchas and running Sashiko against the result
indicates this probably still has some bugs to work through.  Thanks,

Alex
