Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B69CA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD2E10E88D;
	Mon, 28 Sep 2026 08:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KI7bRrdw";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C7710E281
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 12:48:11 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843f22dc83so672485f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790340489; x=1790945289; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mb/FTfEtET6YgPWtFLjQYy9z8TLsr4HMB0wFXAmYD3c=;
 b=KI7bRrdwjj222K5Sd6QBNYiekMHUQYAjZvff/Aai264LnRXtD/C6UdVhor3cf+tls/
 QyXzFeqjgbXYFwIkakpBRe2YbrF0fP8IPmwWs4NxDq28ayP1Y1SuV19xV90eQFzrJTDf
 p1K7FZNZ+dfjqxaA4nMZ9lBimLz1teGz+6r+dVtev7EqKCqA+HBAU6MEQUq+UKNVWKNW
 cdEU87PK9xVhU1v5/TjSjpoKRQ8EcssxMB3teSTNa2ntHEBqC97uOtZxoe9f8Lcd0r9n
 iHaZVyTO/5IeA/vegOSyL7btuq18SiaszJpsNRsXmZFAxH8AYHfcTO3Ztn4V/y/rkJMb
 N5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790340489; x=1790945289;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mb/FTfEtET6YgPWtFLjQYy9z8TLsr4HMB0wFXAmYD3c=;
 b=nKZ9A1Xsmf1yDLS6+KDwJsDKVxG08xL1LQxhrNTqutTrqvcnRLpttoJgTOLdV8MkLB
 m/1pYct6D61652ic1KhPGazK4+nQ/mKsQHAFfV0RsrtRtg3fchWW4Ha7ltJ7AyEvpZEO
 Qewnwq9iDsuykrglJ6vEQ3TRHPAo0dHiPh/S+9CkEVSnao12mjiHKaDgTi6IpA4EtNvi
 VpTVVZOHTkpd2f1fg7bAIZSeUHjJy7gHKJCBwG0EBRY4c5f55Da5h5VN7TGJYGiw3D/N
 od2jeSms6+UdjoEs0hBOfojVFlczynjampgD9mx+T1M3oKxpu5YJBgpCPn+YGT5lASRV
 Gpfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXB18H0+XfsO9Kw1GflI46qRs26pi73K5s1hucqsbBRbu4HxlD04tilxw4xFpfCybaKNQRmG4Vubw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kO3rJzr76VVJTxfY98Z6Cbn/Okhc/MsJdlo7bqgzcltejCUb6G
 5L4Sibmr3m2xJ1p63pBZXiCuK4DHfIQlP1t0CYl2f+VbpLim0q9KOwwr
X-Gm-Gg: AYBFou2Tn/Z2sfSTXUcsTqeQgiqHti2swz5siPeUMGVQrt1TjOuNFnkg3HtKx+M4RE5
 pqiGKkbbmuwbAZXWLIEwrwypw4x0MNXGRmLiIt0+HrtcoqDE4Z6nVP1+14wsvrOsKJ7lSnEcTaF
 qV8EWkQYxrTiEO1QkKIP/IZAmurergz4wTYMI6amf7KpeiP7ueomvVZCFLprv72ZTwpkmnQ5CgO
 3LW0exCTefBCFDOjwYnLJ9/nVzHr7/9ARn3IDMEpaJLYIW3MwI8cyP2ukOIRwBBJTMIqpEyIu+s
 5hZadZOZeysaIeIXFKNB5DPC37t380vEYWpa0TemthY53cOYF2bWEwlkJyci4RmnKyVTfbLm5/L
 tqYtPuLbQVfihzxxataFQHgFn/vYGUpJYQhnM3Eh7Z057AWqr+J8pud3ZSPd0Ut4K7RahA2kBgU
 TCmRrrzfU5Z57oEfHCUKX4D+dJ7DecpIDnA+F+L4K2G9wLJi5AiiWdhPLM5uk=
X-Received: by 2002:a05:6000:400f:b0:486:f856:1975 with SMTP id
 ffacd0b85a97d-48872a7ed6emr10250041f8f.22.1790340489018; 
 Fri, 25 Sep 2026 05:48:09 -0700 (PDT)
Received: from fedora ([2a02:587:200f:d100:bf67:f785:caad:e278])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a36189bsm6670499f8f.21.2026.09.25.05.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 05:48:08 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: Koby Elbaz <koby.elbaz@intel.com>,
 Konstantin Sinyuk <konstantin.sinyuk@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mail@taterr.org
Subject: [PATCH 0/2] accel: Replace deprecated create_singlethread_workqueue
Date: Fri, 25 Sep 2026 15:48:02 +0300
Message-ID: <20260925124804.58808-1-mail@taterr.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

Hi maintainers,

This patch series replaces the deprecated create_singlethread_workqueue()
with the more efficient alloc_ordered_workqueue() in the amdxdna and
habanalabs accel drivers.

Both patches have been compile tested with W=1 and produce no warnings.

Best regards,
George

George Karagounis (2):
  accel/amdxdna: Replace create_singlethread_workqueue with
    alloc_ordered_workqueue
  accel/habanalabs: Replace create_singlethread_workqueue with
    alloc_ordered_workqueue

 drivers/accel/amdxdna/amdxdna_mailbox.c  | 2 +-
 drivers/accel/habanalabs/common/device.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.55.0

