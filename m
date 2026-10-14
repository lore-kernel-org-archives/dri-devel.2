Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BBD1CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BEE1112146;
	Thu, 15 Oct 2026 07:56:43 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 288E410E335
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 02:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ok
 dk8hxm0dW/XUwfuxYTgGwSE96/fYrUOqgmlQ1vuHs=; b=oIIglN6gPucGyfVL1t
 WwtCGfdfOtcbKWfbJKEEPpHZIKPJFLpLFh4JrWh/JJyLQnR3j1CuBlsU5Mr62nHf
 4FliQ9fVZrp1kd7rSINBIE/7lxu3cuHkQkACg+2T4DjKN/yWGPTjieSEhz/ozaLB
 YYrs9kuxCrE8yXv4UVqKrRh5c=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wD3f2Et7c5qnkk1Eg--.60824S2; 
 Wed, 14 Oct 2026 10:47:10 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: david@lechnology.com
Cc: brgl@kernel.org, linux@armlinux.org.uk, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 hppiscas@163.com
Subject: Re: [PATCH v2] ARM: davinci_all_defconfig: enable the current ST7586
 symbol
Date: Wed, 14 Oct 2026 10:47:07 +0800
Message-ID: <20261014024707.77051-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <c2dcc1be-ede4-4f80-83ed-3aeb0590f576@lechnology.com>
References: <20260814075624.16639-1-pengpeng@iscas.ac.cn>
 <c2dcc1be-ede4-4f80-83ed-3aeb0590f576@lechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3f2Et7c5qnkk1Eg--.60824S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUeb18UUUUU
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7Q7UnWrO7S6BLgAA3i
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

Hi David,

Please add:

Fixes: 9b8f32002cdd ("drm/sitronix: move tiny Sitronix drivers to their own subdir")

That commit moved the driver to DRM_ST7586 and made TINYDRM_ST7586 a
promptless compatibility symbol defaulting to n. The old defconfig entry
therefore stopped enabling the driver at that point, before the broken
compatibility layer was subsequently removed.

Thanks for the review,
Pengpeng

