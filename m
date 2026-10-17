Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2766CCF2C9
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 21:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A5710E0AE;
	Sat, 17 Oct 2026 21:24:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2231D10E00A;
 Sat, 17 Oct 2026 21:24:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A7E1560142;
 Sat, 17 Oct 2026 21:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0A01F000C4;
 Sat, 17 Oct 2026 21:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792272248;
 bh=AkackGthM0ACztfHQSKlksjMmW/YOmqa5GxN172PZr4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z+MRfz1nwEoFPZ3U5jurBA7bwERP+PxbMzn8j8QdZYxqMpQmjuP3q6IDPEedDMo4r
 K6QeZfdAhlB3nwVbmtkKmDnZbtcfgjaPvwJ61v+SQcYcnHUA4zVLsMv9eVJ36MS9va
 02e2RCCxNwr3nDUFjw/9FmfoiXiJbZ11tVns42P3ikyFx5zaWjh1rasBW2ZpmPtmsq
 bzjVFiB1bYW0VrR95PAgslIqLnH2SGspGfFLSsS3/14meEwiqjDajBewJZS92prF2Y
 ZjPoLNYgNt8ImEw/zNjxllVJHVzlKtBkRQzc5w02hFHsS2l2qsl6vtwrPuWLSmWr9c
 ze8g4rQxC8e9w==
From: Danilo Krummrich <dakr@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Alice Ryhl <aliceryhl@google.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Liviu Dudau <liviu.dudau@arm.com>, Lyude Paul <lyude@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>,
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>,
 Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: (subset) [PATCH v3 0/8] drm/gpuvm: two pass locking for exec
Date: Sat, 17 Oct 2026 23:23:57 +0200
Message-ID: <20261017212357.99295-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261001220632.3190896-1-matthew.brost@intel.com>
References: <20261001220632.3190896-1-matthew.brost@intel.com>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu,  1 Oct 2026 15:06:24 -0700, Matthew Brost wrote:
> [PATCH v3 0/8] drm/gpuvm: two pass locking for exec

Applied, thanks!

  Branch: drm-misc-next
  Tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git

[1/8] drm/gpuvm: allow locking external objects in two passes
      commit: bdb1dfac34bd
[2/8] drm/xe: lock the resident BOs of an exec last
      commit: d420ec95e4b8
[3/8] drm/panthor: lock the resident BOs of a submit last
      commit: 13b7dc3f89ca
[4/8] drm/msm: reject a submit_bo table on VM_BIND contexts
      commit: 222f78f461cb
[5/8] drm/msm: use DRM_GPUVM_RESV_PROTECTED for VM_BIND VMs
      commit: 872403c67851
[6/8] drm/msm: lock the resident BOs of a VM_BIND submit last
      commit: f3473658eda3

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
