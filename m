Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF290606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgDMf9rC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F7E10E0EA;
	Mon, 19 Oct 2026 20:28:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E8710E0EA
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 20:28:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E39143751;
 Mon, 19 Oct 2026 20:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73791F000C4;
 Mon, 19 Oct 2026 20:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792441705;
 bh=SwI4M7PzemP7Lrt2HFu5ElwpuokYBHAx6W3g1VLHeqI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=LgDMf9rCuuNoZKSAL//mS5IVPqaFZ9rlMmLRvzGN+9dtgfvC3qxHzYLASl8ChPi2b
 pa7bOElycaCCYGJawGYAjoUvLQ2LhNj7RS12fdSYcY5sjzQWWf385nwzs9k+IDCehA
 HSahndbqS+dFYobH4Msu8brU390qwYALaNs9NvX+ICCB1bj7QkDd6qcDjdxOtQ59cG
 PxhV05Q+mVVZPKaq0ekj3TLT+d2UT09DCuO0yCOUC/RgpLCn9vWpi5LMMwjJI2YQYp
 mSSSuhW1Td52x0ktpooQhTWihVM21vH32JklNDrsSPgX8QEp9ChkXossVesapguZZ3
 pHjFV/S4OkwCQ==
Date: Mon, 19 Oct 2026 13:28:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <riana.tauro@intel.com>, <aravind.iddamsetty@linux.intel.com>,
 <raag.jadav@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 <ogabbay@kernel.org>, <lizhi.hou@amd.com>,
 <karol.wachowski@linux.intel.com>, <jeff.hugo@oss.qualcomm.com>,
 <carl.vanderlip@oss.qualcomm.com>, <troy.hanson@oss.qualcomm.com>,
 <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
Message-ID: <20261019132824.0f2b3350@kernel.org>
In-Reply-To: <atYJLGHqCelhzSee@intel.com>
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
 <20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
 <20261016180714.05fc93c5@kernel.org> <atYJLGHqCelhzSee@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 08:12:28 -0400 Rodrigo Vivi wrote:
> On Fri, Oct 16, 2026 at 06:07:14PM -0700, Jakub Kicinski wrote:
> > On Fri,  9 Oct 2026 10:31:51 -0700 Zack McKevitt wrote:  
> > > +        type: u64  
> > 
> > prefer uint and then no pad  
> 
> same here, u64 aligns with hardware definition why uint should be desired?
> I noticed the review prompts, I fail to agree because we need predictability
> and align with hardware definitions.

Just because u64 is defined to be aligned and require the padding.
uint is a "modern u64"
