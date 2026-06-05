Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C708ECD8C8B
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 07:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF57112D5F;
	Sat,  6 Jun 2026 07:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sWXqNCvO";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C8F211A7D3
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 12:11:24 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-36dac5d5d05so940647a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 05:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780661484; x=1781266284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5RoN9ngqvHdCpUoddEnCEeh8fZSHGeByQdCtjfNZBdU=;
 b=sWXqNCvOMNLOImcGOEOAgsIREIYvrFREGx7PrDVa2YU2rEc2X67TbErgwVT10KUqN7
 2cdy0YGm2n9xdUDGZeY8hYhnFU0U3LBvHPm5o9ap2fyItwBYxJCRBuzLZgFlK372SDG2
 5n47KdjCWCsl8nucBHSwuKGHtGxcDM3kQOU1LV/hmuHWDEb91i6d+JTrIFtjS5RELqsv
 I39mqOmQx0/DVyWJ1FhwtPxWzTL7rWNKd5uQskFddqs812pwVB6lGiGA5B3NALcq/gM0
 5Si3nf3hKCGL8nyqAWqk5vcISvgpRRmsw/y4lPzxx6F2NsTVRa2+gaAjQWNm0aCJ/XDh
 KcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780661484; x=1781266284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5RoN9ngqvHdCpUoddEnCEeh8fZSHGeByQdCtjfNZBdU=;
 b=nPapBCAWCKD/PngI076yVbHe2X+gaYAUBsQlvcl/Uh1fKyYEOcWioi9ycET15vnKpq
 v33GDXYnSdH9PqkQs5E+M/XRX4/EF6E5RU7rtDkoQ3bGefnvwvnHEsZTh79526piczCR
 bbyu73u3qALR20/O3HmdB1iXHXxB54XguZunDwTlSHGGwQIAGQcsfQFadktZYi6YT1U5
 oJ6n4JxC48Rm3GthxJSbQU7zSZQ25D6ztsts0CYbyjolDEzlS9SYLDaE7w8X6sIevznp
 DL38SDD82Keo22vJ+WqLul/MJe9f+Bc5eB815j0UNU19MiRhzZlmG8js/SXglw0y5llw
 4CAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1Dkybqor+HqW8wzSIBhbS9bjW/W12/1buze7vWzMFAipfbH+tmgLyEA9xn8hPZTC7s2RBCwZQzKQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzE7IxmoFTtFz7vUuvS/NtOCX7ifx2lR8JqedriCmyX3SHmD8vK
 nh3V/hLUdmYqJzsEjA46+oyObLVsMypxu+ziEDBNJnBPuunRUzVw8aY0
X-Gm-Gg: Acq92OEx7lGXwCcYif+3foh9CpT4b22sCGAzcZwGe3fgAas/TR9l2kIJ/+i/t0lpgXh
 yte7WQVVruBc4h7bfb0NZrWJzUzgNPxiGZLXVJf5INYHNJ/vWVjb60ryTS9Y3l4gqFsu53RD4+Y
 QwAiMBSm9B3kzMVhncpD1U7wwuhd/B8IZ+BzEyl2c15pG1ss1valCQGZTWs9KYTqcJ2J9qvpvvd
 l4k36/2bQa4KJ2VWrvLj7YyX04KkcUZhClEAbUtWJygRvW1X34t81/jmdcy9xvdFwnfIfHEKj7V
 0ey0aGdVzK4bKOQiLkoGlx05ObTf2SGX5f8+Fj8LTuZunsLBJ7oO5FNuR3XSfMDUZgkwrlVeFmo
 uN4iQ4XOXxjZ6r/4VoP31ufrXz4wPJgaz996ZFFAf8E67nRNcnxbnenRZGstVs9m1rsFSVQeY+j
 /BXor1M2vyDMyTausxImLOyVC/Z3dFBBqxLORwzp+jnP26TykSuE6kl879vKrgpaCX1NpVzBFkk
 2cMvdrkd6ybtqaqNuVWj7w4URAPREayvDP0VsRdRYGN7wqHMcjceA==
X-Received: by 2002:a17:90a:d40b:b0:36b:9798:4f6a with SMTP id
 98e67ed59e1d1-370eee04b8cmr3336521a91.10.1780661483873; 
 Fri, 05 Jun 2026 05:11:23 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA..
 ([2405:201:2011:e829:4eb5:db6e:9a22:fd31])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f6bf903fasm6300497a91.2.2026.06.05.05.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 05:11:23 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
	dri-devel@lists.freedesktop.org
Cc: Liu Ying <victor.liu@nxp.com>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Abel Vesa <abelvesa@kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 00/39] Add i.MX95 DPU/DSI/LVDS support
Date: Fri,  5 Jun 2026 17:41:05 +0530
Message-ID: <20260605121112.27866-1-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251011170213.128907-1-marek.vasut@mailbox.org>
References: <20251011170213.128907-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 06 Jun 2026 07:19:14 +0000
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

Hi Marek, Liu Ying,=0D
=0D
I brought this series up on the i.MX95 15x15 FRDM (IT6263 LVDS-to-HDMI on=0D
LVDS ch1). It mostly works, but I ran into a few issues around DI routing,=
=0D
LVDS format handling, and DC enable sequencing which needed rework before=0D
HDMI would come up reliably on the board.=0D
=0D
I don't see a v2 of the series and things seem to have been quiet since=0D
November. Are you planning to post an updated version?=0D
=0D
I've accumulated a fair amount of rework while getting this running on the=
=0D
FRDM. If you're not planning a v2, I can clean things up and send one based=
=0D
on the current series.=0D
=0D
Thanks,=0D
Piyush=0D
