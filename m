Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348B2FF885D
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 09:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E4210E530;
	Sun, 26 Apr 2026 09:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G0UaYBSj";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B131610E19E
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 09:47:37 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-35fbca04006so4611761a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 02:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777196857; x=1777801657; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vAS4ETnzVa+zgF2nxAAi1cetwDrRrqxC6W6wHfZIEQk=;
 b=G0UaYBSjkFIZRf8+QHCKcE1fJqWOqeDcOqbdmuELRaFh3elC2nroR5fNZM0+BpG3lc
 MTcohJmEZmoihX1qtj6N8D4iiUhEyjxn13+9Hi48IQYHvwi7fU8/NZHuv2KOVdiTF9QZ
 6Piieh3qtKrhm3VTJdfFE3sz4KcDB785huDfHXM2FL0WA9hh7gbRBnGQIj2eBH2KQ61R
 OSs65Fr5Z5jAZpZc8Y4ocfQ4xcJxj2pcmzGmKNHHK32q+mLbu4ohg+Ufl6HCv4DNTZNK
 dduipNnXUjOOHBnPPMzrTsaH+415TrfVZsyP7YeDkAFqTd4i136tyA5z15fcu8fmtZ6x
 OiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777196857; x=1777801657;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vAS4ETnzVa+zgF2nxAAi1cetwDrRrqxC6W6wHfZIEQk=;
 b=fWXYiF/bJ1NjQnBsnMkzXBOJYtxA7Dkuh3JVlGDv98mSySwt1/HCDJm1jbcDvZ1hZ4
 MIdub7+/NwQ6lI0FNMkoL8b/ro/xjz/ml+fTNEYWTh8/zFHDUhvuAQWO2AQ65NoT1TXL
 GWdmz7pUxxHaGAWzSvEiJXexx4hiOxuAdS4+OXkqGYLCjtODvI0Lf+EvyffJELovDIlC
 Fmh8kh7QBEH38tTxuqD/aYyHZ0NIM/xuuQ1Tv7rUuR9taFAiYq4yyLBUJqaHvKC0sGsA
 vjpDwq8nOvNwkUQN7T7e00GPfqFPIIcANPJg+EEORlHRppEh5TGkEpC4jIxDMzd0CNKX
 Exeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+S+8iR1BRLFgJhLytnzhWhZh7xP6d7KdpHITUQuk+1sZtgmpAqMynPdrIzP7ZG+7m5BcIp5298Lo4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxov7QENx3v5ykikD1MqiyrQ/0pMXeDkxoNwLvDjZ4yM3MMJ9Ku
 NlxTX1Q0JBKSAtyC1dmJgX14Z+zwO7r2tEgQr2U3X68+IpydVoE3yplA
X-Gm-Gg: AeBDiesACd3b2X/zBbFuMGVGCZ/HAoeo9TliBk0xfn2ORf1HDF9lqKaZJGPf/yZqzdU
 Ok5UnhdQO3kq5WhVxwXEYOkW/YcBnnPQb3sxVbObaagPUFb4qRK5euD6Q00TghzrJfNJpHEQBra
 WSvbo9adpJVnFzaAa/fVFPJCSrSGBzWIpctzL3g39dzgb0ArlDg4VnBTY9FQLqmedvz+4XS9ls1
 ccbiEJGqhp3XT+/PRCCxP1UT+51FsFzsrghoF8kVB0Gr910rsAGlBaa5OY7IWxryr9jPrkVurTH
 NgecyXxZAJlH77bUZ2y1SjML0FBY38+OWnhjW+HNhccu8ob8gvoSlIMOmb2Ssi6vK4CZx3heDqq
 wMdhWqIBX1fsD6xKrmTe/bl3viDRiIfjOcgJWRHrHlYGIJQ5mszYTKUjei9nzF9xNj3nEezSAud
 EjmhSUQEpjVsSnJIojhcINB+21JkBLw8qacwZYWuI0rBiNnw4njKcXGr2ByJYu0dS0qOL/jIKkU
 GQQ6rp5c/lgDwk=
X-Received: by 2002:a17:90b:2243:b0:35f:bf4b:c396 with SMTP id
 98e67ed59e1d1-361403ca5femr37242198a91.1.1777196857110; 
 Sun, 26 Apr 2026 02:47:37 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com
 ([106.51.164.157]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3614371a7c8sm28450073a91.5.2026.04.26.02.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 02:47:36 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: dakr@kernel.org, aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, daniel.almeida@collabora.com, lina+kernel@asahilina.net,
 lyude@redhat.com, j@jananu.net, mkchauras@gmail.com,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/1] Rust DRM build fix
Date: Sun, 26 Apr 2026 15:17:24 +0530
Message-ID: <20260426094725.2188668-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

rust drm gem shmem doesn't builds due to an import error of ARef from
types instead of sync.

Changelog:

V1 -> V2:
- Removed the 2nd patch as it was by design
- Removed unnecessary braces around the Opaque mod
- Minor change in commit message 
V1: https://lore.kernel.org/all/20260426082234.2026908-1-mkchauras@gmail.com/

Mukesh Kumar Chaurasiya (IBM) (1):
  rust/drm: import ARef from sync crate

 rust/kernel/drm/gem/shmem.rs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.53.0

