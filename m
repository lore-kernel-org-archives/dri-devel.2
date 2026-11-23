Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B729606A33B
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6OZYZQI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 838D310EE3F;
	Mon, 23 Nov 2026 14:12:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 601AC10EE68
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:12:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52E5C62129
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F191F000CF;
 Mon, 23 Nov 2026 14:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795443152;
 bh=GMI4Me2ARFv/4uojQIezkuj7KG00oQdLi8a3gMfNyYw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=S6OZYZQINeSdk9a1HcPQTKfFzXeTSQQCP/XOCS7hYqZ7seehwGV9ulIonfWXVJ6Ed
 rp+2dl0E9yz+Lr/+Ghz/+uKcjMJAPZqJoFWdN57u37aRfYMuLhMHikpgJUvyUa0doQ
 4XM3oKjoAhEAkyhKQeaq1vLztctfMAfzteTrLkq7epqFrfAJiYZ9LU3b39sfrs1axH
 PENtQzkCW4L5tfnU6hRrGfSuWzHaMvMHX5EiPqPjyx0FlNE6YQVoeOWXkj9scWJBbD
 59E/9cuM6eY3gvf7wkn/9QqWHTXhcPdzFS5KQHn94UZrEoKO/SZaUZGGuZFkGxs9VA
 wt9/pKQzLhT0w==
From: Maxime Ripard <mripard@kernel.org>
To: linux-media@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>,
	dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCHv3 00/13] media/drm: cec: add HPD_PRESENT
Date: Mon, 23 Nov 2026 15:12:27 +0100
Message-ID: <179544314318.1189238.7248780865420148038.b4-ty@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1793863347.git.hverkuil+cisco@kernel.org>
References: <cover.1793863347.git.hverkuil+cisco@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 05 Nov 2026 08:22:14 +0100, Hans Verkuil wrote:
> Using the media CEC framework the application receives events when the
> Physical and/or Logical Addresses change. However, if the Physical Address
> changes to f.f.f.f (Invalid), it does not know whether that is because the
> HDMI link is disconnected, or because the EDID does not provide a valid
> Physical Address. That can happen because the display does not support CEC,
> as is the case for DisplayPort inputs or PC monitors.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next)

[01/13] gpu: drm: sti: call cec_notifier_phys_addr_invalidate if no HPD
        commit: 87eab2c253293b14d0b47ea9680654ba2592ca95
[02/13] gpu: drm: exynos: call cec_notifier_phys_addr_invalidate if no HPD
        commit: d35eaf955b325239ac67d51e910e149cf59243b8
[03/13] gpu: drm: omapdrm: call cec_s_phys_addr only if HPD is present
        commit: a4db1e6625e4bb77fb7e7d937d85edb9bd511c58

Thanks!
Maxime
