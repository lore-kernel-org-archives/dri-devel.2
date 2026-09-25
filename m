Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CECC98318
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D38810E889;
	Fri, 25 Sep 2026 02:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E3ZrmD0g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2665810E889
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 02:07:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 968FC439B6;
 Fri, 25 Sep 2026 02:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400121F00898;
 Fri, 25 Sep 2026 02:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790302031;
 bh=7IMr+1Y1gs8musuB3lxBDbTxUTorIIZaFvz4JGe/z+Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=E3ZrmD0gEVbadu51DlEnTFlPiQkxkkUgK90N3+D6DZjEmmLLpjTW1okHt20EAoM9h
 OIMcjpA1wi7msPiFj74jNombscyGa1IT1JjMRJ9ga5IFMMrxtRREaaYk94sWecatG9
 GlfRToEhu/Z9kHJaeokPPaZsOiPKtfgdyfrp1e/drGWqUkhZ9AMG0FkIQowQC4UE/h
 hVoy44X4JCV8ertbl4BJARqLZxABtqalhf6VNupmtBDWagLwjexRa1cisAb9TC0HZb
 mandoVixuNcsVsJKqP/H0kwzofol1C225s5NGPezHL/EURmdBJTx5z/4d37Bt+vVfN
 9HsnY5WLmT/uA==
Date: Thu, 24 Sep 2026 21:07:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Heiko Stuebner <heiko@sntech.de>,
 Maxime Ripard <mripard@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: gpu: Allow Hi6220 Mali resets
Message-ID: <179030202997.2926646.12844524842767365149.robh@kernel.org>
References: <20260921232758.3136548-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921232758.3136548-1-robh@kernel.org>
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


On Mon, 21 Sep 2026 18:27:58 -0500, Rob Herring (Arm) wrote:
> Hi6220 Mali nodes provide both ao_g3d and media_g3d resets. Require
> those two resets and their names for the Hi6220 compatible. Other Mali
> Utgard nodes have at most one reset and do not use reset names.
> 
> Assisted-by: LLM
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/gpu/arm,mali-utgard.yaml         | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 

Applied, thanks!

