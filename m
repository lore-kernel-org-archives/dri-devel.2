Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0F9C5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E7C610E773;
	Mon, 10 Aug 2026 09:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hMINSRiY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319D810E786
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:43:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CA5FB400F6;
 Mon, 10 Aug 2026 09:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EB21F000E9;
 Mon, 10 Aug 2026 09:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786355021;
 bh=PE3la7kJoE92Zs2PXzBN9WmBrRf1yXIrmM2DdbArnXc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hMINSRiYZ4Yx1LMwLCAhYdw2AYMzlLyUmH3sjk1nGdnVFbIGysVzDZkYY0L7xBOmv
 lsxYACj0IZHXm4wrplC3MxPDGwqjQXylCuaDvNoDfhMgqIzMv+2d8pfqJ8EBlYL9Sq
 QDFJTRSlxQIlMP17JrZUJhJRbgooKBe3MbViWxOuC9XOzS70lgyA0CrI44M8fuGf0T
 vBnn90TjQhykCie9QWcZQ9oGlqV8SFdw95xPKkekXpVl7Xb5mccU63vKO0E3esaagr
 sPp/ERIPYzQwoBZhxrt5IZZ3+qsoc0bCyPOWL+6D2y3rRueDmzfNbh3uXgQqql4hZ1
 xt6eEKxpAxiXw==
From: Maxime Ripard <mripard@kernel.org>
To: dri-devel@lists.freedesktop.org, John Harrison <John.Harrison@Igalia.com>
Cc: Maxime Ripard <mripard@kernel.org>, kernel-dev@igalia.com,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jani Nikula <jani.nikula@intel.com>,
 =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 stable@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH] drm/connector/hdmi: Fix out of bounds memory read
Date: Mon, 10 Aug 2026 11:43:37 +0200
Message-ID: <178635501197.53478.18079946297287958635.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260723220652.533345-1-John.Harrison@Igalia.com>
References: <20260723220652.533345-1-John.Harrison@Igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Thu, 23 Jul 2026 15:06:52 -0700, John Harrison wrote:
> A helper function was copying a given audio infoframe into the
> connector's copy but using the size of the destination (a generic
> target, sized to accept many different data blocks) not the source (a
> very specific type of data block). Thus, it was copying 60 bytes of
> data from a 28 byte allocation.
> 
> Fix that by using the source size instead, together with a build bug
> on the source size actually being smaller than the destination.
> 
> [...]

Applied to misc/kernel.git (drm-misc-fixes).

Thanks!
Maxime
