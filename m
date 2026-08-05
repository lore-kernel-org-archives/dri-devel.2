Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAD6C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 08:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA6310ED7E;
	Wed,  5 Aug 2026 08:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="ALhxq/ar";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF2510ED8B
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 08:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785919374; x=1786524174; i=natalie.vock@gmx.de;
 bh=LtUfpkKsvcbTVegdt4x9pcsoO4AbcA5u2Mqcmm3gZcg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ALhxq/ar0k2V/HxohPyXDOFMRm4xQtjUcj69m/9ozwXQ6AxJ52LiKbEMRZCx8Zac
 Bxf2dXAg3a4rHAvhmBKr6YynZEen5DY68AT4rj4zVk8Aq32ptaxw1wtVN4WRmT8Uo
 KNxmNCAW0/TVHKO/RG+QmJ9VjNUfFmzbeXw19YwzQ85t15Nq3dptCghFDkYyzXm+q
 NBVomQeGWxa9RXzPBaju1oA+40YGD9BYcAcozso7aKRX0vRABOWqm4raAAtZwB2fe
 0ZT6yvGmbYVej4WI2a/RAtL8UH9rDR/I0yLQLfAkDhCr3m3PCJNdiHUjrwjULfXMb
 QryOToxiG1rBmtlK8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpNy-1xQ2gO0LD8-00bao1; Wed, 05
 Aug 2026 10:42:54 +0200
Message-ID: <868f11b2-3a6f-42e6-9de4-34ff836a9421@gmx.de>
Date: Wed, 5 Aug 2026 10:42:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/6] cgroup/dmem,drm/ttm: Improve protection in
 contended cases
From: Natalie Vock <natalie.vock@gmx.de>
To: Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20260804-dmemcg-aggressive-protect-v8-0-07af96681bf8@gmx.de>
Content-Language: en-US
In-Reply-To: <20260804-dmemcg-aggressive-protect-v8-0-07af96681bf8@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Mwk9/GGQyJMMa7BY5+1gYmWv+B9MvM+zbIGNjCfk+Vb/a5zYRHP
 5PUt+yI5LNmqVcpiHwkhZ25/VNZFghpqZbNHTAKB1TfpMGra2aE8FIdbV49FJDO6hZK5OG+
 m+iYPgIOE49ljCfn4CM0IdQGZXkGjM5OkDHWT2XBa46FnYEBsMs+NV/q4v6T/PM3cnptnfd
 7TSHbZNDkiMhEoZBybEJw==
UI-OutboundReport: notjunk:1;M01:P0:tp35kWKb9DU=;4vLFUuZWJTeIzUiqM9dsZzmUB61
 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
 s8e07FxVVrR6fTrM8ed3jNSnt+W/3IqSlA==
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

Applied the series with a small fixup for patch 2/6. Thanks everyone!

Best,
Natalie
