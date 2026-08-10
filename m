Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CBCC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4502F10E7B2;
	Mon, 10 Aug 2026 11:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bqAPbsBL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C386510E7B2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 11:08:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B413408BC;
 Mon, 10 Aug 2026 11:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276651F000E9;
 Mon, 10 Aug 2026 11:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786360133;
 bh=PN3U5+DtpVJrmJH8fLDfHxDJRV1AQ+2Jyb3klF/NgAs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bqAPbsBLra/XYGjvIi9LO9JsSTAT6UYyzViXi4+yDPW8p8QoitnjdNqy3M0/zfZzn
 JhqzkVH/5R6Nju0EDHL6ipNPTbywOjuIMlb7I5bJpQh79uUSMbkGK65GtEufi+9cEK
 hYROb5YIdC0rVmAl0Pv3jk0QxqFO6Hh1Q0weHx67uROXV+l00bkD+Dh6TFOxb44kgR
 uJsfEnrVhLfvMqjDsa9vbMDhwKyDyuvyy/HZGwLXaoYwIC0K0Ql16QHuFDOTpsx8T2
 A6K/aVKz3Gf8n9XdcmhfNTjG9yS7UsU+knD5QFvFQSg8Gt5LaF+/B9epNMkoQRHO+U
 M8wz/4YgUW5eQ==
Date: Mon, 10 Aug 2026 12:08:49 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Shivank Sharma <shivanksharma2376543@gmail.com>
Cc: lee@kernel.org, jingoohan1@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH v2] doc: ABI: sysfs-class-backlight: update outdated HAL
 userspace references
Message-ID: <anmxQaxHo8TPV5V7@aspen.lan>
References: <20260721132253.256422-1-shivanksharma2376543@gmail.com>
 <20260721151939.331067-1-shivanksharma2376543@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721151939.331067-1-shivanksharma2376543@gmail.com>
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

On Tue, Jul 21, 2026 at 08:49:38PM +0530, Shivank Sharma wrote:
> Replace all deprecated HAL userspace references in sysfs-class-backlight
> ABI documentation with modern references (systemd-logind, udev, general
> userspace).

Do these really add anything? Use by "General userspace" sounds so vague
it might be better just to delete the Users: field.


Daniel.
