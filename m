Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C955C10987AB
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF1110EBF2;
	Fri, 20 Mar 2026 16:43:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="1eFpiqnh";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD0410EBEE;
 Fri, 20 Mar 2026 16:43:33 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 144A34E4274C;
 Fri, 20 Mar 2026 16:43:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DA110600E0;
 Fri, 20 Mar 2026 16:43:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0D6DD10450CB7; Fri, 20 Mar 2026 17:43:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774025010; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=l2/0qMEBnz0wEmduXn1YsXP2N4tpgW+UrcJak/YgRgA=;
 b=1eFpiqnhu8jL4QqYMk6Nj90WcnVMM2T/PV9py5O9JjZNijPE4lk2fTxsbiYBVAQsN+bMGz
 5RVvz8sl0Cr4IsioMNyXp2IlteJ1GIudA9VwNLJoddLyi2cfkOeIX6ZvQoo2qmHyB7dng/
 sNHigPctiv5ygRxKDuPaYNv6Cez9bb+xpaVtNluY0BgzbpiXzAucIIIPdbd5iDXFt2uUdf
 iM5prkP8TvAOXlvZm5EOBdtN09uMF1TSIqEfpnI+gxuqQH8yn/2Xxcawkummj3Z6OZgUxZ
 ZnNlg5yYVZuTzxWVHDcfy82ue2tKxbq1fTZxBFVxh/ZOwElhp7gRZJuEG+LndQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 57/65] drm-dyndbg: add DRM_CLASSMAP_USE to the
 drm_gem_shmem_helper driver
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, 
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, 
 jani.nikula@intel.com, ville.syrjala@linux.intel.com, 
 christian.koenig@amd.com, matthew.auld@intel.com, 
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
In-Reply-To: <20260313132103.2529746-58-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-58-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491473.6181.4769114576501981136.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=364;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=bNyBURlttc/XExJGQqT9iSQSmZSoEUxSyBmQgzWQcg4=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjbLeUiTGg/m1oYfAr2LZw5X9Yuk7DqnfmMp
 BlPpdYsXdyJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab142xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOKcMg/9GjEOamwfWm0vXiAnHTLBB3HbRXVrE1K
 CzMvlNm6g3AhUGsf38q82m0FT4g0yOBL+PjslJdRFY8B/R37jUoP1Xjl1YlM89bEadTLah8dX6l
 H6BQCkQv1UW5mpv6FYJkYciaCoBbSlG1MtrFYzO4jG45qTh1jIIbk7dIdrETbt+5uN0uDZZcI1M
 MTBDTUU1jHDU6qSx21EYdKfkzypbvWx2DMl3DhpKpHAmkg6nOplZ0a6rD50+WkWqxEJmLy89byz
 n67deb7NIp5SvDtQzriPhjH+4+/5RcJtaLA+VBHxU6G7Ff5iTBBLsfsgcP11MQwgReRoDDi3YgV
 xfq66DMhvdNonnpflXrptT4KK94n5TS34Uj2G7TDqixHIfS47kInqFZpXycrBxm7yt86Um/lPKq
 5LRCapOGoEWuPvuWlEzQbGM97nLZUWqzdqnjay8T+8bIchKYtJKpK+yZu495WFroGM6dyV+9PDL
 Kij4cRzVdlL33QpLZb7WRi7SnDZljnn5vfvDEDlGtsVxY9VEAn0N1K8SNT81q4aITPhkQzIgrRq
 F02xxrLbkZWDWyaj+GeqvHwkP9KJi9DBom2vuMNjfjaliwWU8b8+MPgCw4KC3rX68RhBI7LZrvC
 RxzD4ECSricuetZo2kWkkvJEQoiw4LcFfM8UiGGQbQntT3Y/bHP0=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri, 13 Mar 2026 07:20:22 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> The drm_gem_shmem_helper driver has a number of DRM_UT_* debugs, make
> them controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling
> dyndbg that the module uses them.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
