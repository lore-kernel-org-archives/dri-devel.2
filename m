Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7D606A326
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OiRub9bP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68D211212B;
	Thu, 26 Nov 2026 08:11:05 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A67710E3C5
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 01:23:21 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso13706293eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795656200; x=1796261000; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Urp5/OJ9NylMBAWTCtZAf0CBN7LWkjVlT2t9qwaMlY=;
 b=OiRub9bPHaZ+7EGQGZqqbBhTt6CFukW7kf6UoWm6tiOWWZcJvlv5gPz/uJqa8e25sH
 VtjnscbSw1C6iK8rTPrxiY4MintC4qCY37IwXuppFHdkdiCAdfPz00c0J67niBwztOTT
 gJcTj4IRVVA1nmX2F+OpFsdrXDB5pKFtZOMm1LEQI1p00MgPtSfucuM1/6HL1sHtBmWF
 3u0kZUr5BLJ+/viIFbUeKcGygvtCBlDje0SaLpDd4ChRQHfbAPZ7/6JlNwp+y9GBqwjJ
 6L4xFMc5WOrcZog7eAHbE0Gmfyu3DtqQRKgqszcAE6ypd8v2jN6Fipsd7sqNbInHJlzc
 Fuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795656200; x=1796261000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Urp5/OJ9NylMBAWTCtZAf0CBN7LWkjVlT2t9qwaMlY=;
 b=A0HLlbeisJJfhY853sBl5W4+Y5EtoKDdQPmaBcK8xMBW5UJSxMf3d9mRrIEynMKP3a
 sqdHyJTcYAD5NuY/QpxnooSnyJSLrv8821u9lrOTNev92YFji5dtavHGMzyYruuY2lde
 AuhFo27O1zNJgnx1Hwa9UQCnIROoDdMMpHJA/RJ4qnJtt7211pNJDlf4EVFckP0e4+5D
 Cve24ZuFgLNKZVY9FpdVL9bC7JTlVgxfv+n5BVcrCpsQKtwXii7ylv6er/CDbR2KseLI
 KaiVM45sKWDau3cE/+BfRVvwah5HZCgJUXjp+zCuS+4OALATHaCpKHgu4owBDOHZ//16
 5lMQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH/LaDwkhSe9cXuyZPg8DB14PJEHb0BOVTqOXeCKnOgoamxcJqH6CT4UrNXyXlpZe7ySWTAYDmOhes=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8nahfvxAruBggUPxLvT5E1DsSIA+SH+bhtyqgXEsvYRrd+g64i
 A1MnO87dIgNArPcJubjvVa9rhuGBHaeAcdr2wpM1EkrQ0n5j7WMdjYX/
X-Gm-Gg: AZFdTZd8SczAIbHlB74UGKxDB7zzydF/pZEX+N2aHaPAQV1RzFBB7T43F0CfrG8Jigt
 CJhsoqE9/JX0rGIiUrUPm3famxTBObSF73WUDsQC/GzjDOeQEWxO0aqzdgz1X0Y2SfhMGC1sxVV
 WlSj7rBDgxQRQjDXBxftK2XIb/sl9/nEIAn7lCayH/W39/SUBCv6gnIOuCnf2xRcNJYmnchzwbZ
 iAD6mTWMBIxrP+LDE88BNdW4c3iRkZeXI7PFEBYVNsWPIPmiBVZbkPnBsClF5/+oZftoAR7gkVX
 C2pzNSYPQYps9IDJgPYmBgMqrcs26Baf/DxhkKk9/Q/4yZUEeBGzargloLaKgqoYLuI8QUUaz25
 eKRnOsGKGcg04Oid9Non4L5Olx4l4ODluyUkA55deUEALQwwYBFlXqgC0d3KJORwflk0k+0YTsd
 wfXBUzwFCxcCEyhxADoPRzckZ3XzUIAzuVx97zfEjKRtpa7MOAu105BBf+wUG2uBr2KMxpeT5hu
 GqwSRLjutjuF4UIBy8ndrTuW4xTosYKzxvdBaPjxU9+N9RtRZ7lREPiyOugCtHO2hMrTiyN/VcM
 B07jgn05wcH24wBvLJTqRKg/7LXRAxXDro2rfjUrDg==
X-Received: by 2002:a05:7300:c00f:10b0:36c:a321:9fbc with SMTP id
 5a478bee46e88-3856c9a6858mr22818091eec.1.1795656200044; 
 Wed, 25 Nov 2026 17:23:20 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd4efesm59360148eec.12.2026.11.25.17.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 17:23:19 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Huth <thuth@redhat.com>, Weijie Yuan <wy@wyuan.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2 1/2] drm/amd/display: Document the union in dc_probe_status
Date: Thu, 26 Nov 2026 01:23:15 +0000
Message-ID: <20261126012316.2624853-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121041427.1743954-1-takano32@gmail.com>
References: <20261121041427.1743954-1-takano32@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The members of the union in dc_probe_status are described one by one as
@u.bandwidth_mbps and so on, but the union itself has no description, so
kernel-doc reports:

  dc.h:2225 struct member 'u' not described in
  'dc_probe_status'

Describe it, saying that the member holding the result depends on the
probe type.

Fixes: 52771a3254ea ("drm/amd/display: Wire probe commit path into dc_update_state")
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v2: The disclosure moves below the --- line, where Weijie Yuan asked for
    it; the commit message keeps the change alone.  The patches are
    unchanged otherwise, so the diff is the one already posted.

Written with Hermes Agent, an LLM assistant; the author reviewed it and
ran kernel-doc on the file with and without the change.

 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d3c484f45333..debdd69bbe4e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2207,6 +2207,7 @@ struct dc_probe_latencies {
  * @valid: true if a measurement was latched.
  * @measuring: true if the hardware counter is currently running.
  * @type: type of the probe that produced this result.
+ * @u: probe result; the member holding it depends on @type.
  * @u.bandwidth_mbps:         peak BW in Mbps (DC_PROBE_PEAK_MEM_BW).
  * @u.latency:                min/max/avg memory latency in ns (DC_PROBE_MEM_LATENCY),
  *                            stored as struct dc_probe_latencies.

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.53.0

