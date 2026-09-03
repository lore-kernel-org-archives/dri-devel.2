Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BF2C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5C9210F4AD;
	Thu,  3 Sep 2026 09:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wl2HdFNv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A849710F4AD
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 09:53:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7369A43B4D;
 Thu,  3 Sep 2026 09:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDED1F000E9;
 Thu,  3 Sep 2026 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788429222;
 bh=d4y5Hn0EBhF1grLy92/G1W/mcg/unwEoTt2qMQQaKU0=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=Wl2HdFNv9ck/rElbAHmVFE7nflBnSrTW/tfAbnLXNxct+5s8QoGWdWEuLrtkVAgIH
 aubllsRn5anEp99KO2S53jDaNAV4Sdkxg2EHuyNG10qKEogM0O8B/ZDQ94VRWGkCc9
 kRPfwxJNU5iNQhCdr3ol7l6l/XBXOMBdfX9gQptSmoTJSBKUnndiJv6MHhOMVnt04h
 BKBtHga7MjLjXl3WK2L1l9HmTwPY4i9sP7BiZvkt+7TuJrR1bnda03AwXPkX9A+NXN
 9T6KF4eleru0QB7elLk23qFg4IGxhsf9BJuqqVJV6gJ/yfayZNfGg6BIX5/+aH3/Z4
 6SAks6FXSpRaQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 11:53:38 +0200
Message-Id: <DL5L8WQLEHTO.145VJ5NIXMCHE@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH RESEND] drm/sched: Create faux device for KUnit tests
Cc: <oushixiong1025@163.com>, "Matthew Brost" <matthew.brost@intel.com>,
 "Philipp Stanner" <phasta@kernel.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Shixiong Ou" <oushixiong@kylinos.cn>
To: "Maxime Ripard" <mripard@kernel.org>
References: <20260903090256.552317-1-oushixiong1025@163.com>
 <apk_YgCd8fbXC7Lx@houat>
In-Reply-To: <apk_YgCd8fbXC7Lx@houat>
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

On Thu Sep 3, 2026 at 11:36 AM CEST, Maxime Ripard wrote:
> What's wrong with drm_kunit_helper_alloc_device(), or kunit_device_regist=
er()?

That's probably may bad, in a previous patch that tried to support a NULL d=
evice
in the scheduler instead I mistakenly mentioned faux while making the point=
 that
we should use some mock device instead.

Thanks,
Danilo
