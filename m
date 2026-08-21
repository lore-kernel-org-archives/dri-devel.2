Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF38C5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26D0110E187;
	Sun, 23 Aug 2026 09:26:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=holtechnik.com header.i=@holtechnik.com header.b="JKyOfB2C";
	dkim-atps=neutral
Received: from hognose1.porkbun.com (hognose1.porkbun.com [35.82.102.206])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF6D10E273;
 Fri, 21 Aug 2026 08:27:32 +0000 (UTC)
Received: from localhost.localdomain (192-184-175-24.fiber.dynamic.sonic.net
 [192.184.175.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: phollinsky@holtechnik.com)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id F10AE47DBA7;
 Fri, 21 Aug 2026 08:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=holtechnik.com;
 s=default; t=1787300851;
 bh=BeYDma4yqixg754zEJEPNG4NaT8r182s7Wc6Lq+Vgxs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JKyOfB2Chooz4/QDYnCC/6rW4ERTSqQcZTP3iU7lfzHM2lrIqJFzySI3h9SiwTlWT
 pEhfLUeJqXpdOcHJm7NHTOb7mUpvjTIbK80+NQRWDN0/eWMGOZE3V9eoSeeKsFdArK
 AkueiCrdo+beqd9tMd06ge2mINe9kklnsZ8h6hOk=
From: Paul Hollinsky <phollinsky@holtechnik.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Konrad Dybcio <konradybcio@gmail.com>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: [REGRESSION] qcom PAS TZ API migration breaks GPU and modem on
 TrustZone without PAS (sc7180 trogdor)
Date: Fri, 21 Aug 2026 01:27:30 -0700
Message-ID: <20260821082730.89413-1-phollinsky@holtechnik.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <943d1db3-f117-4e9c-94db-7221b47d9d29@leemhuis.info>
References: <943d1db3-f117-4e9c-94db-7221b47d9d29@leemhuis.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 23 Aug 2026 09:26:47 +0000
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

On 8/21/26 08:33, Thorsten Leemhuis wrote:
> Just wondering: who will submit the proper fix to ideally fix this
> before the culprit hits mainline

I have now. I sent them as two separate patches, because the two culprits
are in different places:

  drm/msm/adreno: Only check for PAS when a zap shader is present
  https://lore.kernel.org/r/20260821081325.89088-1-phollinsky@holtechnik.com
    0be72be03ca7 has in fact already reached mainline, in this merge
    window, via the soc-drivers-7.3 pull (Linus' merge 368cf60c36a3).
    So this one is based on Linus' tree rather than on msm-fixes, which
    still predates the culprit - it went in through the qcom tree, not
    through msm. It is addressed to the msm maintainers, but it can just
    as easily go back through the tree the culprit came from.

  remoteproc: qcom_q6v5_mss: Don't require PAS for memory protection
  https://lore.kernel.org/r/20260821081540.89137-1-phollinsky@holtechnik.com
    f3b1357673dd is still only in remoteproc/rproc-next, so this one is
    based on that branch and would ideally be picked up there before it
    is sent on.

Both are exactly the shapes Konrad agreed with in this thread, and both
are tested on the affected machine (Lenovo IdeaPad Duet 3,
sc7180-trogdor-wormdingler).

#regzbot monitor: https://lore.kernel.org/r/20260821081325.89088-1-phollinsky@holtechnik.com
#regzbot monitor: https://lore.kernel.org/r/20260821081540.89137-1-phollinsky@holtechnik.com

All the best,
Paul Hollinsky
