Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE43CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2D2D10F35D;
	Wed, 30 Sep 2026 12:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=trailofbits.com header.i=@trailofbits.com header.b="Gms8TNCE";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 992B310E16F
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 01:03:34 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-34b3e517e6dso658757eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 18:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=trailofbits.com; s=google; t=1790730214; x=1791335014;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k02DnUfueq2SXs3UXLyiifb3Iga2OW/KGZeFQEVs3F0=;
 b=Gms8TNCE2XMQs1rpfPQDMDNSl4FU5LIhmB1wyXJZS3pqxas3taX7xei8zvLelk5Z2n
 ImksXDgNCU6mUYzZ2swnJ39wMAiTEQ+D90EM5XUiFZKXtyJGsXIG7CCjsuXktHbK+k4c
 eaps5FcLR7qjBJydEFuwT3nFCQe7hQV+9CvAntOo6PZC8JNG7TMVDYYXvP9o5NUwxrCT
 YiWcNAn2nUa0d9XzTaubhoR27ybyvcWZqB7R8qeU/rl2/B91kGY2/zPMvkX0FTgCPEUW
 4H+XGl+iKM6K12aMDfPVQz7kr9emNm896VYwXarhs+S7J6EPVeliiiwLJOoffWs9YR9/
 /srA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790730214; x=1791335014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k02DnUfueq2SXs3UXLyiifb3Iga2OW/KGZeFQEVs3F0=;
 b=ctJgQZxzlgP6fS2Fuyf+tnS2/szAA1wV7/JUjTzduKWC4lyqLQqqP/P/KWiBWIeJDd
 Ko/O2CjqR+Y8+kyiROFWirncX3e2v81eZWPr23CZ6cMgVaHIFxvUL2frf8C5dfMGlFtY
 yL8saCtzplEtZGEOoLD918NCKymvcsPSozdPFnDfj4A1jA50XtGlEEXmnjDvIRijdtvl
 TXpskx1oSrPcndPof8bYF4oxNJgkLbIv2E/KjUfY7ygsiCiQI2HfeBgszJftdGWsIJ1O
 0doSppRkHB3XunKkDVuheV7DV2PKnLNJYrqMIR4WYUYMgP3w+vOIC6mUjJh3liTdQGBr
 mNaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrEoS3cOTkjgpPzncuifiNUMjg9T7z2ZIaxm8QM9fONJJnApfxMym8NWWs9IxTC34OpcDR5uIPBAo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kE3+Ta+2sKJFkHw5vDKWRdW+H+Zxjfe2qiqfbKFPtlf4TekuIq
 /dBUqib259nCuTrRvx4v0/enHEDV2MldAjDsjqvuKurJv7M8KgRSxXkHJlWnpnXk6Gs=
X-Gm-Gg: AYBFou30unEb/aTRsp4kz2aLr94poWJQMiVL3CumrNSxfWtVPw7bf+dPWn8x+quWwhM
 nS5z2HFzq9CY45RG1JRV5PzCW1MIC+jiJALgYmEtNSh+QPR0iLGpsOhTBlLOmnCySyIFItr3/eD
 s3C6kdn9V3d/+2Qkx02F6o1IYkFhprs4OM84A7iyd7Ct907a2fDxTVidNyrgZbvL03V++GILeXw
 8GmWdBgFLBQc+B0X+9sH2tSWH6urw4AOqRUFyt5Z2XhQQzQOL+xaNDAlar9BevqYg8rzyXG7OlJ
 rSQTFKT/wi8+xX9i2/0R67VQLyBKlmzGnPbrxCmtXNv+lAT2nnASW284KHY7TaoBpfQTkyIIluq
 yJtGvXeAhFSIPfWu0cQdwrfXawBDzQw2BK+ilR5w2XvVKXsV2OOcj5Dz9Ig5qBa2J6DObtaIum3
 swlvaU1QjCusiUh6jGiQCF0EPot1f7lil/eMFd6qX4nYhxa+yJAoLoVw/6w2nzenuheyynIU1ZY
 NR5WwJc2yHHDOFC1/Yii5oks5DDfF5uiKquSyDtHBOFqFBIrPblzgAegJoYJr+DJKntGV0=
X-Received: by 2002:a05:7301:4e46:b0:33b:f5b7:f4b3 with SMTP id
 5a478bee46e88-34c646ce08emr1028241eec.27.1790730213667; 
 Tue, 29 Sep 2026 18:03:33 -0700 (PDT)
Received: from localhost.localdomain
 ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c386c2723sm2179993eec.18.2026.09.29.18.03.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Sep 2026 18:03:28 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Suraj Kandpal <suraj.kandpal@intel.com>,
 Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Simona Vetter <simona@ffwll.ch>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y v2 0/2] drm/i915/hdcp: guard both capability checks
Date: Tue, 29 Sep 2026 21:03:19 -0400
Message-ID: <20260930010323.93999-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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

Hi Greg, Sasha, and i915 maintainers,

Thanks for catching the second dereference.

The code in patch 1 is unchanged from v1.
As Sasha pointed out, on 6.6.y, however, intel_hdcp_info()
calls intel_hdcp_capable() and then intel_hdcp2_capable(). Guarding only
the first helper therefore moves the debugfs NULL dereference to the next
call.

Patch 2 adapts upstream commit d34f4f058edf ("drm/i915/hdcp: Add encoder
check in hdcp2_get_capability") to the older layout. The 6.6.y tree
predates commit 130849f8ec14 ("drm/i915/hdcp: Use intel_connector as
argument for hdcp_2_2_capable"), so its dereference is still in the common
intel_hdcp2_capable() helper rather than the DP and HDMI shims. The
adaptation puts the encoder guard before that dereference and returns
false through the older bool interface.

The CNA record for CVE-2024-53050 starts its affected range at 6.7, but
that range follows the later shim layout. The same unsafe conversion is
already present in the common helper in 6.6.y.

Together, the two patches make both debugfs capability checks return
false before converting the missing encoder to a digital port. Both fixes
entered mainline before v6.12, so every newer supported stable tree
already contains them. The same common HDCP2 dereference is present in
6.1.y and needs separate handling; this series is only for 6.6.y.

Could you please queue both patches for 6.6.y?

An LLM helped adapt and validate both patches; I reviewed the resulting code
and validation evidence.

Changes in v2:
- add the adapted HDCP2 guard identified during review;
- send the two guards as one series because both are required for the
  debugfs path.

v1: https://lore.kernel.org/r/20260929031728.88004-1-artem@trailofbits.com
Review: https://lore.kernel.org/r/2026-09-29-daily-reply-0012-re-i915-hdcp-encoder-check-v2-6-6@kernel.org

Thanks,
Artem Dinaburg

Suraj Kandpal (2):
  drm/i915/hdcp: Add encoder check in intel_hdcp_get_capability
  drm/i915/hdcp: Add encoder check in hdcp2_get_capability

 drivers/gpu/drm/i915/display/intel_hdcp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)


base-commit: 79643295eba17affbd16ca97f3ef04c90266b28c
-- 
2.39.5
