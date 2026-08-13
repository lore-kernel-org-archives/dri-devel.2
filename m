Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D4EC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6980010E4CA;
	Thu, 13 Aug 2026 19:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="AJou4Yc7";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-85.mta0.migadu.com [91.218.175.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE56710E4CA
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 19:51:07 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=17dVxIH1CvllIJesEjIOaBpOvBmfOb14zH804b1OIYU=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786650665; v=1; x=1787255465;
 b=AJou4Yc7tZoOLoASEcVBtlPnjMl76s52U2QglBXdbVFXwQAexVqEzFHYHd/W5zODYJbCEJDl
 Oxp/Dp9mjRfDH2D95ft8CF2B+eqZyvjO/4qts0h5roF3XjliyRGhEMrW+FEcFtRKnnzJcyidLb+
 Oblkmqj9L8g0ETwQR4N4VYwi15WJ8heo+PDMeICSJIq1zqC3qAIZMo2/9Qfk4Top6Ib3vqPGSSu
 7VbH9YSB4et2mU62538eOBpZUufWY/rQdtEcUGi6a3v5q6gfd9b9l3vyIBrvzfaKJ44v5mFxtrm
 /UYmysrGPjUoGjRTdhQiZ6s4YbOhO++/JSUATVcClkqNQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id 66fe8caf038be42e;
 Thu, 13 Aug 2026 19:51:05 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Alex Deucher <alexdeucher@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: taimuraz@kaitmazov.com, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Max Zhen <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org
Subject: Re: [PATCH v2 0/5] accel/amdxdna: honour the SYNC_BO range
Date: Thu, 13 Aug 2026 22:50:58 +0300
Message-ID: <20260813195059.149991-1-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CADnq5_OR5bFoFJoMoj9bc2_f47TunVnDFrmA_2tT+0k-DZk_jw@mail.gmail.com>
References: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
 <a505f9e5-b416-43e9-934d-c5c29b8a70e9@amd.com>
 <9420bbe5-46a3-84be-eae8-596bc42bddac@amd.com>
 <CADnq5_OR5bFoFJoMoj9bc2_f47TunVnDFrmA_2tT+0k-DZk_jw@mail.gmail.com>
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

(Resending to the list -- my earlier copy went to Alex alone.)

On 8/13/26 21:54, Alex Deucher wrote:
> PCIe transactions from the device should snoop the CPU's cache.

That is what I assumed too, but it is not what I measure on npu4. Leaving a new input dirty in the CPU and running, the array computes on the previous contents, each out of 20 runs. Flushing that same input and running again, it sees it - so the data does reach the buffer, and something is not picking up the dirty line.

What I cannot square is that ubuf maps with dma_map_sgtable() and nothing else, and on x86 the DMA API no-ops the syncs, so that path looks correct only because SYNC_BO clflushes on top of it.

Is the array expected to snoop on this part? Happy to run whatever would settle it, or to be told what I am measuring wrong.

Taimuraz
