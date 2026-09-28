Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F813CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9133410ED8D;
	Tue, 29 Sep 2026 08:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="j7t3mA1D";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D5C10E0A1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 09:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nN
 YAy905/eGCkrb6hwdLmwg2oEZ8qaop0g8gQHQ/JLo=; b=j7t3mA1DXWngluHkCV
 xbI/Re8xnNmNJwgNkC7EZhuV5CONnWXDfv0yLiw6GWkVIWXi4xyNlpgpohCVSgvT
 Oe3T7A/62Lx6kJL1ADW4b/prWIkwfmxJd8ybi7Zq5iMpcy1J6MSyv2/XRUNJr7Wm
 GgPlSmMvU6jin6tM6AMEfb6eQ=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wD3X0WIN7pqt_x4BQ--.13130S3; 
 Mon, 28 Sep 2026 17:46:49 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Quchaosheng <quchaosheng000406@163.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ARM: dts: ti/omap: drop unit-address from
 tpd12s015 endpoints
Date: Mon, 28 Sep 2026 17:46:47 +0800
Message-ID: <20260928094647.2021321-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916123210.107841-2-quchaosheng000406@163.com>
References: <20260916123210.107841-1-quchaosheng000406@163.com>
 <20260916123210.107841-2-quchaosheng000406@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3X0WIN7pqt_x4BQ--.13130S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1DJF48WFWrWr4kGw48JFb_yoWfArXEga
 s5uF4kJw43Xr4xKrnrKr9ruFZxArWDCFWUCFyUWr1Ik34FqFsrJF1ktrs8Xr1Iqa43Kr4D
 ur9Yqw1kAa47ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUjvzuJUUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wk5rmq6N4lEqgAA39
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:22:37 +0000
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

A gentle ping on 2/2, which nobody has picked up yet.  The binding half
(1/2, dt-bindings: display: ti,tpd12s015) got Rob Herring's Reviewed-by on
09-24; this half is the two-file dts change that drops the unit-address
from the tpd12s015 endpoint nodes on am5729-beagleboneai and am57xx-idk,
and it has been sitting unassigned since 09-16.

Two questions, whichever is easier for you to answer:

  - Should this come through your omap tree, or does it belong with the
    binding, through Tomi and dri-devel?  The two only make sense
    together, since the endpoint nodes carry a unit-address with no
    matching reg property and the new schema rejects that, so they should
    not land separately.
  - If the form is wrong for your tree, tell me what to change and I will
    resend.  If you would rather not carry it, say so and I will drop it.

No urgency on my side - I just do not want it to sit unowned.

Thanks,
Quchaosheng

