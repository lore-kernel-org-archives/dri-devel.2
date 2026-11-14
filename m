Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB85606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nEGYSqgK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054BD10F039;
	Sat, 14 Nov 2026 16:25:12 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED88F10E328
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 16:21:30 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so17960445e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 08:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794673289; x=1795278089; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SAXE+Cbl9G5IRb7happTo9S2j4c3HyT4UpqiPP6R4YQ=;
 b=nEGYSqgKccYPIdejY6mTM4PtibEH4zwpfXdA8KF+ukioumHsp6AQdx9CQEw39lSCNE
 ETt/qtayYXJI2IRPbO2u2oPOFYjkkapiu+Z9enXBR92/kxZDMDhgS6G/xDvlmmj6RPgx
 /fwRGc2+OH8mHwr24APJSUyjTDqbAGTWWPChCGcA8FUj97Z3mU1xEkDmU/LW4SNFf8//
 DD6V+fa2pF6TireXFdo3pnBg5k1j/ZxiUfHhrg2/gpP760wkOYT6Q1g6V2AkvGULvboz
 wmRLghLTHD/hTD6jx/dLHjcN77Nsucsr7WIQgLTQIuxCJbJjZjlZuK5oCg8uGas9WT6O
 4KYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794673289; x=1795278089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SAXE+Cbl9G5IRb7happTo9S2j4c3HyT4UpqiPP6R4YQ=;
 b=1bOhqf6pru/iMh/WExOWB1gOV5QjwqUWTJth6awLyVsL3884nBNx3h1rtRRqcFW9an
 esyTXJDs3TAjIct250d+011YFx7B9bnOlE6R5PGuh+xHbwUJ72YmFu2w4KtK2G7EL5Ww
 wQ4eObxpwLKQlIXN1aBLhIvmL41lS7MnUqw2yRQw45gfLwKUUMDeexuMY5zVplUIi5+K
 q98b5ads9aUg0XfrQEF+oZdCgKRZ07FGoAbiCJE/UtcJW5kdzStM0oEONsRoCsmiH8J1
 6oExdejWWflrAvInV2LykxP/N3JjZqRLUG1j535TCpDhzLxk5kiDnZJ/sfY1w3OqCyoD
 LHXw==
X-Forwarded-Encrypted: i=1;
 AL+hErGAvrDSlOjcgoGyazKDEbLaOfqc+Ez2r+hEgTpv2+3CEj+4yMJztaTvm/7zd1HUMxMKeC4EIq4cVEM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ksB2NrPKR/dn4t5tIXPeVew4AFH0HBX3g4T81dXrj/jZscELO
 0NuXCAdD05a1VkS6Sapd88rfVMpHcrs8V95MPzf+4khVEDJVyhlesztn
X-Gm-Gg: AYBFou0SIafYCLBuTkwNhuz8XTWzc7yxw4iSz/pTzx+uoZuqTtHraNC2BeqHQcRM54i
 L9iyNG+wcIz7NZqT+K3C2ZygIT7RQYXBArFdQ5QdNNPDDjZSge8kcY5ob2fw4mr5vS+eYWRJ+fF
 P207iKgF6IqWWwnI4h7I6THgBhtwvRfNo4q0K7gYZjlBiC1q13LStA48SfwVFDL1M+zkSEXJbn2
 tub8acyJEz8XxLCmPD0DDJW5I6DP9nF7O78+gqDCNsLnOfke1TKZpdgGcxp+NpRabSZgAXG18Jx
 4QbF4MshmCeayDLku7EYxAo8GlgM5igGiejTFHDePFYvCKOj6BxSLtE5O/SmjdTRQ5OhgQSRpl2
 0ofbzQNzS9csxwBWRfk1B5SpkHbTyalWcPldRtFAo33AAig1fithD02/fn1Z/5N6FVKph9+QVAh
 alalW5bSNBkDEqX0l7ZXukyW4a6Vsd0glAVkHnzJp2RBc14TFOvMkTIjyaFPl0RqtxVBdivMu+v
 YtdBLNZ5+dz8E16rD7ptaRvyzz6UzQpj0lEvGTXldhPuzO63k1v43qtfHxW5J4a4gO1L1G31tXJ
 atHdmyiD+tbDvjdVdHYIPcEXNy8Z9PjUPMBBpPQ/SjUwgrMrfvtgM4zvVN6oDSZ+D3oFLF8HEuf
 NcDCCoK8GX99mdDUthUUmuid28ztkbPs2+x+x
X-Received: by 2002:a05:600c:81c9:b0:4a1:83f0:7c91 with SMTP id
 5b1f17b1804b1-4bb55a65b31mr117276745e9.18.1794673289246; 
 Sat, 14 Nov 2026 08:21:29 -0800 (PST)
Received: from DESKTOP-0KSTGNI.localdomain ([197.45.81.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae5299sm162652275e9.11.2026.11.14.08.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:21:28 -0800 (PST)
From: Temitope obabi <obabitemitope765@gmail.com>
To: thierry.reding@kernel.org,
	mperttunen@nvidia.com
Cc: airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, obabitemitope765@gmail.com
Subject: [PATCH] gpu: host1x: Remove unused host1x_channel_release tracepoint
Date: Sat, 14 Nov 2026 18:20:06 +0200
Message-ID: <20261114162006.3673-1-obabitemitope765@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nothing calls trace_host1x_channel_release(), so the tracepoint is
unused. Remove this unused tracepoint.

Fixes: 6579324a41cc ("gpu: host1x: Add channel support")
Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
---
 include/trace/events/host1x.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/trace/events/host1x.h b/include/trace/events/host1x.h
index 1b6aeb7b177b..6e9010ec5a3e 100644
--- a/include/trace/events/host1x.h
+++ b/include/trace/events/host1x.h
@@ -33,11 +33,6 @@ DEFINE_EVENT(host1x, host1x_channel_open,
 	TP_ARGS(name)
 );
 
-DEFINE_EVENT(host1x, host1x_channel_release,
-	TP_PROTO(const char *name),
-	TP_ARGS(name)
-);
-
 DEFINE_EVENT(host1x, host1x_cdma_begin,
 	TP_PROTO(const char *name),
 	TP_ARGS(name)
-- 
2.53.0

