Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D980BFF885E
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 06:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DE1C10E529;
	Sun, 26 Apr 2026 06:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qDCeBpWx";
	dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7CA3B10E165
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 18:17:42 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1216)
 id ADD5320B7165; Sat, 25 Apr 2026 11:17:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ADD5320B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777141062;
 bh=nNYqv+mnIIySo0kNUnZOcffgMeHet80rqcnW+qxxHek=;
 h=From:To:Cc:Subject:Date:From;
 b=qDCeBpWxZRE1+JCx4ltYkGovaBNRhPzE2TzfMQUBHVYxgAZPokZIt5wgFVQHC423i
 euZwk37JMBhObzISmEwubaoEA3PQBxJDTz4tTqWljbTVJ3d3jY3OQM5/iZmfbNS2sq
 k33j5ipGYe6C1bqGMFgMZUxsgbFml8UZB20DtEBg=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Himadri Pandya <himadrispandya@gmail.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Deepak Rawat <drawat.floss@gmail.com>,
 dri-devel@lists.freedesktop.org,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, stable@kernel.vger.org
Subject: [PATCH 1/2] hv_sock: fix ARM64 support
Date: Sat, 25 Apr 2026 11:17:18 -0700
Message-ID: <20260425181719.1538483-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 06:47:14 +0000
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

VMBUS ring buffers must be page aligned. Therefore, the current value of
24K presents a challenge on ARM64 kernels (with 64K pages). So, use
VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
hold all of the relevant data.

Cc: stable@kernel.vger.org
Fixes: 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 net/vmw_vsock/hyperv_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 069386a74557..40f09b23efa3 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -375,10 +375,10 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 	} else {
 		sndbuf = max_t(int, sk->sk_sndbuf, RINGBUFFER_HVS_SND_SIZE);
 		sndbuf = min_t(int, sndbuf, RINGBUFFER_HVS_MAX_SIZE);
-		sndbuf = ALIGN(sndbuf, HV_HYP_PAGE_SIZE);
+		sndbuf = VMBUS_RING_SIZE(sndbuf);
 		rcvbuf = max_t(int, sk->sk_rcvbuf, RINGBUFFER_HVS_RCV_SIZE);
 		rcvbuf = min_t(int, rcvbuf, RINGBUFFER_HVS_MAX_SIZE);
-		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
+		rcvbuf = VMBUS_RING_SIZE(rcvbuf);
 	}
 
 	chan->max_pkt_size = HVS_MAX_PKT_SIZE;
-- 
2.54.0

