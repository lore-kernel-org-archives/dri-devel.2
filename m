Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1EF606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e3WHPGu8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F4C10E2F7;
	Sun, 15 Nov 2026 14:42:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C7110E2F7
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 14:42:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 15E026242A;
 Sun, 15 Nov 2026 14:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8969E1F000C4;
 Sun, 15 Nov 2026 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794753749;
 bh=dAUG9itb1DceZsbgfGeIfItJJItPj5Pk5T2lDscbORM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=e3WHPGu8uCEixn7WZ5MdPvpjjsenLQwhcdinvIpUi/EM8Mqs3j0lImHKfMEDN9H2J
 Td05ACPL6A3FSnHLoSj/4tdTM52SEqkFjyZTZ6Zr8IQqlPE2/DDNYJA+9HYtzoIUlD
 jHLkhOKhH6vORFt/DpWu08DPJvC7nZtJM4Yyhcc82iMdSB1BJoARJhcM6a2/vjlHjr
 TRTdQ3dILRNix6CxFeIfLRyMiHtvrmw5dlhhLgnqacSm4l/qJXsOaSirSEsh7+St3G
 /iYcVwLoxFWLgEL63jpuikWPdjNDt7hi9n/hBH948Q9vxVrn3eHl7sCZQ9squo67zI
 HkbC4T1l4mvyg==
From: Chen-Yu Tsai <wens@kernel.org>
To: Samuel Holland <samuel@sholland.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, bmasney+clk@redhat.com, 
 jbrunet+clk@baylibre.com, sboyd@kernel.org, 
 Andre Przywara <andre.przywara@arm.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org
In-Reply-To: <20261115061102.229680-1-jernej.skrabec@gmail.com>
References: <20261115061102.229680-1-jernej.skrabec@gmail.com>
Subject: Re: (subset) [PATCH v3 0/8] drm/sun4i: update DE33 support
Message-Id: <179475374632.3212936.18354501331414111023.b4-ty@kernel.org>
Date: Sun, 15 Nov 2026 22:42:26 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sun, 15 Nov 2026 07:10:54 +0100, Jernej Skrabec wrote:
> This is second series out of tree which aims at properly introducing
> support for H616 Display Engine 3.3. Previous series [1] reorganized
> driver so proper DE33 support can be easily implemented.
> 
> H616 DE33 support was actually introduced a while back, but it was done
> without fully understanding hardware design. Issue with existing binding
> is that it considers planes as resource which is hardwired to each mixer
> as it was done on older Display Engine generations (DE3 and lower). That
> is not the case anymore. This series introduces new driver for planes
> management, which allows doing proper plane assignments.
> 
> [...]

Applied to drm-misc-next in drm-misc, thanks!

[3/8] drm/sun4i: Add support for DE33 CSC
      commit: ea008133ef8078934a0dc2924a8263d645f0ee1c
[4/8] drm/sun4i: vi_layer: Limit formats for DE33
      commit: b1ba050890684fc7615fe4c7d523f4f46c1696b1

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

