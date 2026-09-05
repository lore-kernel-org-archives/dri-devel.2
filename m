Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2ABC624D6
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 09:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D13110E5D2;
	Sat,  5 Sep 2026 09:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="JAsl+hL9";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="mo4PA0WD";
	dkim-atps=neutral
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C2210E5D2
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 09:01:40 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 2254B1400040;
 Sat,  5 Sep 2026 05:01:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sat, 05 Sep 2026 05:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1788598900; x=1788685300; bh=3B7gJtfgo23VO+nTznGk7ne+zYgCnQ8o
 DMOsdHtb2U4=; b=JAsl+hL92E+c/DRdGEZF21tz6wpxt0I1XDiWGcwx4sZlazDH
 FQPlci9qarF0q8S1y/g+kcnl0Py3snOHn6fiWD+QWumBWBsi39IMZz3EhhalDaVx
 EqaFGnbU/o1WoZPT35G16FVxIJv8XWPD8g9mbIGoPAIpFI8KSeQ+6/nLHacAQM5d
 P1vzWlhMFJuWcQwcRVNgHQxRvFUUHklECHp9UduCeK0DBJa/5hTOFtp2a6vTpt9x
 A+h8kjPJKjNXy0pPGw1fGp3Ap35stAzFJGhGEUBLno/R1HBsZtOBOsDT26pEYrrm
 DFcZ9mZ0PR0Ehdf6NdjT2PHzs8QyNsI2FvxDEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788598900; x=
 1788685300; bh=3B7gJtfgo23VO+nTznGk7ne+zYgCnQ8oDMOsdHtb2U4=; b=m
 o4PA0WD7re7wCp6iuB5ajjhr5xdqWPf3aq5mLuCCH5ZbrafuVQcMXowbERiobI8S
 gL2AbYm7BekUQ6zEEZBoXN1agMFRJVN8QO8hyhpuTwZJYxC5cr8dPAH5353PUZBC
 BvfmLSgSp/AFNId4bMnqWDd9eX6NPm/XjOkD78DkTxgnLo5ww7OvzN/1/eJ7DoS/
 kuXfJ9C++pG/64LcukQVGphkmLOJtIpRoyn0QfRTtQtkpPZB1e8JtwVUAWtQKcRk
 jrf0VGOtrxmQEg6DUWWjTGNWU9F7PUgHHgprMLK8WwPh8A0YvqnIrXHzCoahzKw2
 eSkeRg4HqnX/UMpu91Saw==
X-ME-Sender: <xms:c9qbagI84QzhT0-lMgizKzR7J_ktU4WsZSwMPrdVvqMEDWHoS089wA>
 <xme:c9qbahqDSWv6tn0EsQr_Jw5W3cWOVJOjx3odH9ZG9NlLZWFO_sAfKH_hc2jFFxeiu
 C5eVYs8-G26-99VhbXTQsY-GEPyDO1xm2bJ0Kg072-LOpWFbqp4jCZZ>
X-ME-Received: <xmr:c9qbagzrI1e4vmaqQbYQClmUUfu_SIXzy0GpWqIHN7D4NRyewcNCaGsjATHYPpid2IPCJ9C-9g>
X-ME-Proxy-Cause: dmFkZTEYSrnIgFqH7Zve5CKWphECD4dHzCRXMT0THSbWEWGgAbHRBgA0hl65ofVS4GybDE
 mhNPOB6hEr81yHFFTNkxA2XaeRjcRl6mrMaHjzxA9tp3+UrtFTOia51yeQNXP3utIfJ9Ji
 Ny5sW/E3oug/8a1poAzhWYWvo0Ewk9Pue5iUXTRDYE0K6ATvMR43x2v39S4Wu6rsFD5eTp
 e+03Iwl3QVILoZm8uEvhDNfxJzwEs76WFhAJK+UPUEieD0xFcPM5SfK8lsQKmt5zNHwuKR
 ir99+tzb0zA90e97nq7EEayX01uw2XbPcxLaoGqihPWclPGU+4syOES5jrF0Epi7jQpJeO
 5kXNzyNXaycqdCUbnDkWwnqrPpWOXw1mVO4s5n+YgaUGIab43IoKZ1GvWrT2yhv4lWwVzR
 Vx0rvUG3n385kuMaAEkXPZIu0YTMOsnWFR6fqDPsGQ50M70TKDlc01ED9yFxGMcWjl3McE
 gfuo72BDNdE4B4IYTyIc08f+5GcRctGwNOA2R0Z6lf/WSkO3FICWe2R1tbGzGBBD8HCMeO
 BeQNP/a2Ks8+pyirp1Hn3egSSMWaOKgChniW9lxvgmCqqeeQ54yKpse3Lez+7s7Fsi95Gj
 0odvZ7A/VLzPiavL6G3zMEVzyaCb8lg1hCzdlQ/Uu/YyYDz5dCq08wOPknyA
X-ME-Proxy: <xmx:c9qbatM1hHpkSdQKHWcs6aDySyTDogHHJX6ya3KjL3o1VJBod8_iFg>
 <xmx:c9qbat7EY-EdpwJnn7L7RtUNoyypnwsanSEXCCLy5sPhb1i7ApKwgg>
 <xmx:c9qbaumHc5KFleBbtWLeTL_sr5IHb8WLsSPmjEcK8wBI8HdPLb31ug>
 <xmx:c9qbauSO28iZ2vLooHcF_tfGONOX3q4jabVi-4h8vdzS3QsvLyMvuQ>
 <xmx:dNqbajLT6aBl-HroG1f5jie3kZLivf4rtpM59aEKpprGS1_a2dGjWDsu>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Sep 2026 05:01:37 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: royalnet026@gmail.com
Cc: tomeu@tomeuvizoso.net, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] accel/rocket: search every core slot when a core is
 removed
Date: Sat,  5 Sep 2026 21:01:34 +1200
Message-ID: <20260905090134.239404-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904125936.26234-1-royalnet026@gmail.com>
References: <20260904125936.26234-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi Igor,

Two unbind and bind rounds on a Radxa ROCK 4D: bound: 0, then bound: 2
with the cores numbered 0 and 1 both times, and nine models decoded
identically afterwards. Moved here from the DVFS thread so that b4 can
collect it.

Tested-by: Jiaxing Hu <gahing@gahingwoo.com> # RK3576, two cores

Jiaxing
