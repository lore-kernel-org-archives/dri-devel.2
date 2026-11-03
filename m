Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5A606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=pBYt0qz9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8717810E1D2;
	Tue,  3 Nov 2026 22:25:47 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 147C010E1D2
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 22:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=Sas6yqkE0Fbg5xyy1IYM2aopyVjH/aR36j7uaT3Gc64=; b=pBYt0qz9dbLzA+jL6d2+oYGB7y
 ZhuluEKRoGZQgkiEw5tafnQ3UOZNYTBviBjPLy2sl1iV4y6YalKE3xXHIZGdERtsZ43N1Iyg/rxhL
 ZPr8tpTL75b8tBmCVk77pbyFuhIdQQCyjdQibqC+AtoyPurKI0chMfwaGSEKtSy3OAA1qVgJMpE91
 mU6/IEvm8YhAjRnRAFVRtoIebgtFCqUUTmxXHBY5WJK9pkK1SfNiqiw05SPK+eCyo5BmCvq6llRFi
 R61gxWJ9xcvuj7kubbie5e6o1+x6skBtQ8I4m9YYVveI+LSa591UC7NvpN9wxZBH6WGhP3i4Ouoje
 q2k3xKBw==;
From: Heiko Stuebner <heiko@sntech.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Haoming Gao <Naixumogu@whut.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>, Oded Gabbay <ogabbay@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Sidong Yang <sidong.yang@furiosa.ai>, Greg KH <greg@kroah.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] accel/rocket: Fix job submit error handling
Date: Tue,  3 Nov 2026 23:25:27 +0100
Message-ID: <179374472347.512720.18000593798629455371.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828064152.37822-1-Naixumogu@whut.edu.cn>
References: <20260828064152.37822-1-Naixumogu@whut.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 28 Aug 2026 14:41:49 +0800, Haoming Gao wrote:
> Several independent error paths in the Rocket job submission ioctl can be
> triggered by unprivileged userspace. This series validates userspace BO
> counts before passing them to helpers with signed count parameters, collects
> implicit dependencies before the scheduler job is armed, and propagates the
> first per-job submission error to userspace.
> 
> The series was tested on RK3588 with zero task counts, invalid task pointers,
> invalid BO handles, and oversized BO counts. The requests returned the
> expected error codes without warnings or errors in the kernel log.
> 
> [...]

Applied, thanks!

[1/3] accel/rocket: Validate BO handle counts on job submission
      commit: a4569e3b2081b9d64490d425d1e5bce0ba2a74f8
[2/3] accel/rocket: Collect job dependencies before arming
      commit: ce9f76505618a12fc0d3b6d38fe51454de639842
[3/3] accel/rocket: Propagate job submission errors
      commit: 3185975d75f8e72f2db52e3e2ce73e26eb674f9c

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
