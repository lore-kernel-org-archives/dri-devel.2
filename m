Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E10CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C45BC10F5CA;
	Wed,  7 Oct 2026 13:51:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oAiqsCj9";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C06D210F26D
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 09:59:29 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-35120d43ecaso3830325eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 02:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791280769; x=1791885569; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zzBNG15RNJWIVCxEfCEDNKw3ft0cluQEDOTAP62jMkk=;
 b=oAiqsCj9Y5MYQTaq0kvKP+Hcha0eg/F3hKxQ/yA0LeNMRGORQ54tR7r86CoyPgg3/L
 bUZ2jYbQNfDMH9A3ycBNvV2IB0NO2c0bDdnYE5+9MfJXnfunmNH2LtKpd8facRnVco2Z
 JXkpN/vzcvePKavRMKzm4vzmuv5CLoC+Df3W+JFNIdRcOlp6Z27b4S1h9DLlsd98zzxN
 /50eRoni/4LqnSCUUo0Q5i731jfTZ4QO/Vg8REeFFGFoJyf1ipvi2gsJYhFx8TDKqj8G
 4vzHVxdbLFNDBr9Bz7mJo5+5ejPXHkOhKBgob9k3j8qYQHJcEdAsBx6Siu2ty3Xo3cEY
 XMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791280769; x=1791885569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zzBNG15RNJWIVCxEfCEDNKw3ft0cluQEDOTAP62jMkk=;
 b=i796Kd+uNrxNuWkK1GMRTDHlCPeg0gug2wSee9eeNYsdHvHvJr1MPnxECwaPLk3lWH
 EQpw4Pfm2p9YYdyuaHDH1/9eD5es8JO9ea0/C0NK8QWRBpak3zjc/YAF80XzkgYNLxV6
 kAqO1o3NlwtXrrc42tr7MPqLnB+3/tfX6xWG2Dh7IiD/FswEMv2kfSFyGxI0WpunWT6I
 tG9UGgC/pQM+bdZoi8/AQPFwKM4Hga+t89TdW4a4jHSsknui7Go0X0ztAKKQ9SdUA0Yb
 18QxDHDr5T3o8B4uhjoRUVvUJJwKKmV5CrUR8tHyhhPUEtOnWrcSyT6y7y/ouXwpi82U
 6ccQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTW3IZ5L7aaSa6RqZITuQwOb16rCWtKVPs4TovwmBjtkhavqblZXyu7zFHhPFebc+bmcDEInNd4w8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL3+i1nljGK6MCVActjZp1gMBeXBJVgIdCxMMErymEtCJ9BPK5t
 Yn91vQ6INVwTaJGtqN1hv9qyzl+xGS4pJ2umaACqTl87U/devuipA0qb
X-Gm-Gg: AYBFou2IOqxjGaJKRqkNTwlyUh9M/k5zwkrW9Yg+NxZDVumtYlHR4nyEZ62UM9zbgJ7
 qhbjuReQ7R5ivIhOxDFalswFMltDQME+mzPD+lShea3bkl+Bks3Qi4UYZh1Qu8L9Gn147JZARpM
 SoXDfUHmr2tqQDAD/QWCg+Jph8o0M3xAGRMZP4CzvnbAMOZRnczkAZM2fvQtQObaP7B4T1O3ahW
 Mv6u/bZAnCkNFYysVsgcwkRV85bvInuBbd9zXm2xXty+ooVGrgNS4dMFwxddNUeAi8dQBEwy1Ij
 uK0vByfUWNqFRmnwAqAnr7UPTcYv2Au4wFFG9SumNvhbH+xOGtO7fXYV3KqKamQOI36NmVwZ8uy
 7Hapgv3/v+qPMsE0RXDMo9Dh3Zw0zzBacECwROpMEq8sl7oJBrqZ7dJv7gsJgprnZmx95jroSw3
 Y3a2EhUOa34eQjNvOyiIdD+bZcsBhh6xdO3rDdjLbSgFBesTMy7bzgtORMK3iOa9NbHWh4Wropy
 zi+/WkdyIecDbNxa6WfwZoTGMwLMGrR7MH1tz0=
X-Received: by 2002:a05:693c:62d9:10b0:340:e422:fd40 with SMTP id
 5a478bee46e88-3514e2a5419mr1086417eec.16.1791280768761; 
 Tue, 06 Oct 2026 02:59:28 -0700 (PDT)
Received: from DESKTOP-HOME ([2406:5900:111f:dc2a:3071:69c7:a4c4:6259])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-351464fd465sm9305276eec.0.2026.10.06.02.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:59:28 -0700 (PDT)
From: Beomseok Kim <dilddream31@gmail.com>
To: emmanuel.fleury@u-bordeaux.fr
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dakr@kernel.org, airlied@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch
Subject: Re: [PATCH] drm/nouveau: Fix NULL pointer dereference in
 nouveau_fence_sync() when prev->cli == NULL
Date: Tue,  6 Oct 2026 18:58:41 +0900
Message-ID: <20261006095841.35167-1-dilddream31@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordeaux.fr>
References: <1690ea65-a1e0-4a34-bde1-bdd26e31c6c4@u-bordeaux.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:51:21 +0000
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

Hi Emmanuel,

I have been looking into what appears to be the same NULL dereference in
nouveau_fence_sync(), and I found a path that may explain how prev->cli
ends up NULL.

In the failure I traced, nouveau_fence_no_signaling() removes the fence
from the pending list, but leaves fence->channel pointing to the channel.
The fence itself can remain alive through a BO reservation. After the
channel is torn down, the same fence can later be encountered again in
nouveau_fence_sync() through that stale channel association.

The normal nouveau_fence_signal() path clears fence->channel when removing
the fence from the pending list, so the no-signaling path appears
asymmetric here.

I also did not find a normal path that explicitly sets channel->cli to
NULL while keeping the channel valid. If this is the path leading to the
crash, checking prev->cli here would prevent the dereference, but the stale
fence->channel association would still remain.

The existing fence/channel lifetime handling seems to rely on clearing
fence->channel once the fence is detached from the channel. If that is the
intended invariant, preserving it in the no-signaling path seems preferable
to allowing a non-NULL fence->channel to refer to a torn-down channel.

I sent a separate patch that clears fence->channel in
nouveau_fence_no_signaling():

  [PATCH] drm/nouveau: Clear fence channel in no-signaling path
  https://lore.kernel.org/r/20260928081450.19340-1-dilddream31@gmail.com

Thanks,
Beomseok
