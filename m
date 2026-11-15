Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEAC60A2600
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bFi1XQ0g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC0110E10B;
	Sun, 15 Nov 2026 20:19:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E708310E18E;
 Sun, 15 Nov 2026 20:19:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 027DC624EE;
 Sun, 15 Nov 2026 20:19:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794773974;
 b=YM+AZ2TAW6GwlEmMWeMJOTbx/cpfzaezNjCoZuhbgj775//rnDMi2R33JsRu1A0Irdtr
 j7BguaR8amjhMk8ozX868XKI8HrbIxR2mD2iZJT7Nt58Vm5hvGOctote2TcKBLSup3RWb
 yWWjcp/Kzv0Lh5ssXz7G9pKHQo/0axHOLWMcYovwYn08rOARuRsUw4s+wu+aHV9xOkXjt
 CCCjvYIq5sAIkwjQmvCP5L6VVyM/Dqj0KuMFGAk6H+fFSM+stf8kNXnqZqqG4eU9No8X9
 IWzOubwpmruOZBPhdm7NZYC+VSjqgUVnH1IpkBbVzUlxwe2w01oLxP72XDGp6HE42hg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794773974;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=5S9jYnQMkuyeDz5Q1NOvduagtgcKoqbh6U1EeVPzQRA=;
 b=0+GEE6ytXMV6ZbBoT4e0F/nnGnLoveztP2gYiuxHgV2J9GRnKXi9719ubW9nmmRfK1Vg
 kItk1kFS/5aItlwTCY0u537e5D867uYI1zKOBX6ftRw5AH32ClWTrKZQ2vFLkQpo/xerG
 qkMiP4n7dUS1V6dadZAhGo1G8plYspzt6qFFZW/vQgLAXw7DTK/Q7MvPLHU9rVDZKw3s9
 yZ3utVRgjQx1T3ik9AuVQzbCu6+MYlXGBaphO60VvK2/1bzIKNxz5j9VTEg2O6SHLoagA
 UYVWvEf79s89BtFgXew8rqAuGuMUqvRJvzYcJru7T8q9ASr/ZjiYOr0yAjyfhvqljHg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 4428A1F000D3;
 Sun, 15 Nov 2026 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794773974;
 bh=5S9jYnQMkuyeDz5Q1NOvduagtgcKoqbh6U1EeVPzQRA=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=bFi1XQ0g5bJM6miuJaHCHH3Y6ZQ7F2NxrWkg8fMTkA46h6hfmtmOgMT3T5K0t/a3f
 Bq9wuI2e1HojexVUVKbLqM6buoNt5i6csQftGlHErWQVmTAXgbIA2/wMy3IkKVUtZH
 luQndicmZchTUybz6iruTYxyWVZjryuij0npaCq7TeacBGmPyH7LZzbpTnQsaWYkWN
 AcRqB9gY0afQDuoR8ioqrKH+SXTeCdEWjV0eFygOSFefc8SfisRxBzpA0OZ9koy+ha
 a0FNUiR6dyX39CTcYrZmgVan7FTh9VO1sWjSTM7bYq8VFF4s8ib4SGDokRHEmgWWrc
 YvzHLvU9TigyQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C7E3C4A18C;
 Sun, 15 Nov 2026 20:19:33 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay
 <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Subject: [PATCH 0/2] drm/msm/adreno: Add Adreno 829 support
Date: Mon, 16 Nov 2026 01:49:32 +0530
Message-Id: <20261116-molokai-a829-v1-0-fb3005bfa921@yahoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mz3dz8nPzsxEzdRAsjS13L5CQLUwNLYwNDIxMloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAb4z0nXAAAAA=
X-Change-ID: 20261116-molokai-a829-9cb850930124
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794773972; l=1497;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=xS92jhw+RcCvxowDypSEMt3FVi2B5i/aCVEn5+bm/Z8=;
 b=EAWQBoW7ZbtpsmsiNG9rencrsRLCR3iPJpNFsE344sawB5poZPRih5wKxwB5U5kH9U/TGh1x4
 bcwnNu6FPP9Dkyyp4lcJi9cmS5QojvhQ+2JMq0UHAC89k/patDwIU0C
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
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
Reply-To: venkat.yadlapati@yahoo.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Qualcomm Molokai (SM8845) SoC has an Adreno 829 (gen8_9_0), a two
slice variant of the Adreno 840 with a smaller GMEM, its own firmware and
a smaller preemption record. This documents its GMU and adds it to the
a8xx catalog.

On msm-next it needs "drm/msm/a6xx: Fall back to MX when GMxC has no
levels" to boot, since the Molokai command DB lists gmxc.lvl without
levels. The SoC devicetree is sent separately in "Add support for the
Qualcomm Molokai (SM8845) and the Motorola Signature".

Tested on the Motorola Signature with the gen80900 firmware: the GPU
boots and Phosh renders on it with freedreno (Mesa needs the msm chip id
0xffff44030a20 added to its A829 entry, which only has the KGSL one).

I used an LLM (Claude) to help write these patches and their commit
messages. I reviewed all of them and tested the result on the device.

---
Venkat Yadlapati (2):
      dt-bindings: display/msm/gmu: Document Adreno 829 GMU
      drm/msm/adreno: Add Adreno 829 support

 .../devicetree/bindings/display/msm/gmu.yaml       |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   3 +-
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c          | 100 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   5 ++
 4 files changed, 110 insertions(+), 2 deletions(-)
---
base-commit: d024361c631b3f020a26c07d683e5103404b0fbf
change-id: 20261116-molokai-a829-9cb850930124

Best regards,
--  
Venkat Yadlapati <venkat.yadlapati@yahoo.com>


