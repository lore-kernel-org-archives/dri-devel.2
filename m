Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE88710987A5
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06E7910EB75;
	Fri, 20 Mar 2026 16:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="P9oYkNYj";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B3910EAD5
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:41:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E381E4E4274F;
 Fri, 20 Mar 2026 16:41:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B8C0A600E0;
 Fri, 20 Mar 2026 16:41:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5BABA10450CB7; Fri, 20 Mar 2026 17:41:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774024902; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=OoIKC3xiAydsS7WdwjuFaop5M9cp+2hHPK/Ac5EbeOk=;
 b=P9oYkNYjxSLD7hcIx+Ps2DgzF8i0/g0d6wGw6xLPlwQCTKCFhczL2PpF31ySV5kYbfEG37
 gfSQntsCr7ee4LRSE3y+1uq1oHJ+kHGrv+2biqdzzTJLcq/BEssgUwiygss3kNwL4zz7wz
 BDBI2zgON9fXYAbLAELPiV/2vABcE0BtNxzjXLb+WLZomDtIv1eWB0YtCTJ1ooVLBhnA7b
 z1Amw+zn21vEszru8v68W0nnaUdA5SJUHcPivGMcjnQBjGzrviTq1TF3AGGQog3hzCIQp/
 IaOiEQ3pjTiU9akIhrT7Yr941faAxyUJgfgJH/ffDmL0Ce2DyaNjFIOvxbnXEw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v11 03/65] dyndbg: add stub macro for
 DECLARE_DYNDBG_CLASSMAP
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
In-Reply-To: <20260313132103.2529746-4-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-4-jim.cromie@gmail.com>
Date: Fri, 20 Mar 2026 17:41:54 +0100
Message-Id: <177402491429.6181.3451050852733384894.b4-review@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=364;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=YfgqEypHmFY+iYWSVh3YxHOt80IVs8FI3xU4egwmsbQ=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBpvXjWzWHOvXqB62IeaVzwpEQPZBADthXHZLIjt
 MvT/hLJV0CJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCab141hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQIK0uxlsQLOLXZxAAyn+NXUqafxCHdiSZKf3AXJIqR5AgDwA
 uBDFIVDwNlOFwj/GUaScoYdrf7HOmYL2Eoq/fROj3jMsP+Khg+3NAELcs/n3gP5TdH7lE1LHyun
 AVw8ETkaYuISb6v9aqVM3LEfQ719JQM1XQEkUsRgBSO+Tuu+5NyPqlsjpeSMSpKm0jFyQ6paHra
 Q5BByZwmRyOwXE83MFtCQ98SSSaSk7HmYAinTW85eIesKtslAG3EsR8bBwec28HRQqq7lq6LVSj
 7OJPd49gbG2gaMwZuCBejRz6JTtzsnNoQgHZObUhRUB1gPkeEneHUCI2HYP8Simp8nqnHEtoCLw
 IPkpZ8r8M7P6s0iV+OMwBH7qnEXKc6DRSloPLOd76oHPtFi/gNwCz8RwLzaZByvpsL4G1zCn3Nt
 BDjC6ePekEUFoVBRhibEctfOjDv3qLOZYQyIz9SKnK8BpPrRsF3Yuym0JbpBhpL9q6GWfXtfGby
 4uRtVFa9mjCfQbw/dZ8O0OaXHvJUlYu0W83YRrhq32bKKEuSN1u2wfSOix9cMzRvcwyzGtsSfEs
 j2MId7Mhd6r54tOOth/WIn5wDq7jQX7IllGDniMD9pRy+4bub8kDnxz6rnYxL3BOMhQWwJB+ho2
 GtN8IalfmfN2q7uURhp63+Kjbd9XnfkzF9kHFPtWkwLKVgtAZoYQ=
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

On Fri, 13 Mar 2026 07:19:28 -0600, Jim Cromie <jim.cromie@gmail.com> wrote:
> Add the stub macro for !DYNAMIC_DEBUG builds, after moving the
> original macro-defn down under the big ifdef.  Do it now so future
> changes have a cleaner starting point.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

-- 
Louis Chauvet <louis.chauvet@bootlin.com>
