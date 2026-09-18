Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E37C982DF
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0917910E8F9;
	Fri, 18 Sep 2026 13:47:07 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3365710E8F9
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 13:47:06 +0000 (UTC)
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
 by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4hmYng3dYBzBDcl1;
 Fri, 18 Sep 2026 21:46:47 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.46;
 Fri, 18 Sep 2026 21:46:56 +0800
From: shechenglong <shechenglong@xfusion.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stone.xulei@xfusion.com>, <chenjialong@xfusion.com>
Subject: Re: [RESEND PATCH] drm: Fix NULL pointer dereference in
 drm_minor_alloc() on error path
Date: Fri, 18 Sep 2026 21:46:49 +0800
Message-ID: <20260918134650.1654-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <85292368-03d6-49ce-b6df-3bf659347c0f@suse.de>
References: <85292368-03d6-49ce-b6df-3bf659347c0f@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.82.130.100]
X-ClientProxiedBy: wuxpheds03045.xfusion.com (10.32.131.99) To
 wuxpheds03048.xfusion.com (10.32.143.30)
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

Hi Thomas,=0D
=0D
Thanks again for the review.=0D
=0D
I noticed that this patch has not yet appeared in the drm-misc branches.=0D
Is there anything else needed from my side for it to be merged?=0D
=0D
Best regards,=0D
chenglong She=
