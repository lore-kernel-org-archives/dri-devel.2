Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BF9F327CA
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC01810EBEE;
	Tue, 21 Apr 2026 08:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DzeeyDsu";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C27FB10EBDA;
 Tue, 21 Apr 2026 08:54:11 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g0GPD27D5z9vSV;
 Tue, 21 Apr 2026 10:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776761648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=729bf2NE3fMhOUH9wKl65pubnQvcJ0IX6gyysLkVvCo=;
 b=DzeeyDsuQOwfppA4jLI0hObTuAY/C3IholM3OpsCSv3KA8BT3tU2xHF6uZBtS/PN6cIg6Q
 dnQT26A81/w2tmDSugdJ2OWXDVWKrDZaeNMyXVXZ0RDBjsBHkTQn+A8U0EjkAvllHmhTxD
 m5grpAQ6Ze3o+s7PudgUHvqGSEVbJbz9DlNGs5gxKpI7MxfShaP6loR6gFRB2wJ64q0/wK
 EDpwNruXF4lPjXAvHkH3681jFx808p8zQvT9Oyts+VhmETvqnhCcQ0QPoKeqFHztzMFaws
 Vy/H8dtmsN4oCSha573Gjkj1IMMiI3Axt2WPpMiR/nYTrgo+DFyoKxpmZLksbA==
Message-ID: <6f5f44d3-2490-4d19-b6aa-31056410c22a@mailbox.org>
Date: Tue, 21 Apr 2026 10:53:59 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v11 0/7] User readable error codes on atomic_ioctl failure
To: "Kumar, Naveen1" <naveen1.kumar@intel.com>,
 "Murthy, Arun R" <arun.r.murthy@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 "xaver.hugl@kde.org" <xaver.hugl@kde.org>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "Shankar, Uma" <uma.shankar@intel.com>,
 "louis.chauvet@bootlin.com" <louis.chauvet@bootlin.com>,
 "Yella, Ramya Krishna" <ramya.krishna.yella@intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>
References: <20260331-atomic-v11-0-6a1df7ec5af8@intel.com>
 <BN9PR11MB529039EC705FBA4E5E65C64FA72F2@BN9PR11MB5290.namprd11.prod.outlook.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <BN9PR11MB529039EC705FBA4E5E65C64FA72F2@BN9PR11MB5290.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3ek8b5b389kqkyi4cc4jjy5czsuqgf39
X-MBO-RS-ID: 2fe1feb1a8aa5bcc8ee
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

On 4/20/26 10:32, Kumar, Naveen1 wrote:
> HI Arun,
> 
> We verified atomic commit failure detection via capability flag, error code/string retrieval, and fallback path execution in Mutter via MR https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/5022.

I don't see any fallback handling in the mutter MR — process_atomic_commit_error has only TODO comments for all failure codes.

As such, in the current state I wouldn't consider it satisfying the user-space implementation requirements for new UAPI.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
