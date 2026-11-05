Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC2606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256 header.s=a2048 header.b=dlOgT90s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C56B0112C76;
	Fri,  6 Nov 2026 09:19:16 +0000 (UTC)
Received: from sonic307-33.consmr.mail.ir2.yahoo.com
 (sonic307-33.consmr.mail.ir2.yahoo.com [87.248.110.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCF410E378
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1793910672; bh=K7X3jIFeUdX2aCLnfTXpJofeHqRyc77l/ucvXAjIb3g=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=dlOgT90slMZVMdIRWryP+O8aX26JBTwqwz9OojS2DIp1rpXW6DV4c4p+OlH+0KO9BWcOmJpmafxtjQLHKqdtww3kFMS/MmHXR1dDYiwrqJQox/pgEse6mNBgVC/aIpXs/mdkZxqXwVcFnhn5mhd6NzSiCH3G09aW3odwvY1GMU+fI6aTOqhN/m8Jns30NGnRR6v0ZeCbmBJ8mLrT7YHFaEGaIQc8ZORUonp7AH/4OvAQILM3DVcEikxtZ6ghKjMczU/K68c98s3uk2vnzd2Hh6E5PNZzlzW3qokzdGQyujgxf3h3b3Rz49XVAslIla8uU9BzQEScMZ0qaeM7kV34Gg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1793910672; bh=7eqo1FIbbsSFWoRZOXtPSDMoE0n1OfciUaVF31oB1cp=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=gXJ5VOPBu8onIyPls+q0HMRxU/XSCXiJd2DHa0zcsoNo7Bd5Cnr/8dLj0QL75g8W13On0aBEhvm9wnVc8ep7/EhyF0I38aNxZexXqg5KJLI+cUrCkC4NcS7T4uGLno2mqCzvkicPq15JpoANw12o3xd0UkaHj2iXLym+Av0ZDosYto4z+FwCKhYfXztcAsLOSan7CZPlcTJY2PaHbuttQt+kK3p9CEDotTZ88QumTfl3xjJCGJdXBFtlc16tZepVvtFc6YdwnhlW7ZEaYufFgF6ZimblbUmRqMledQ5D1EjPKnUvs8GIamf6AfK3WRwaYQiknSEiLbwijuOM8ZbX1w==
X-YMail-OSG: ZRV7w1YVM1megUljiU0GdUHioqQAyweq7owbCha_g_t02O5onfcws0tyDFw0V5v
 6MrSya442P9j6a44fzXP7RyvOWAX1.zr8dAJF7OnoJFAJkSh6r5Yv3yJ2bzuwLF_csYh1tkmVnGq
 yWmmnpMkujRTGw9G0A8XDWN9RSnUSuE195ew9Vy7ibcAzpkb4blj.dAHCZMG2CSDNmxeAXgWw2hd
 nRroS3bcI9V7v450Y30dtDO6.RVScaBr85XRqN2iD35X4Z48exJCunSYvH3xs2D8HiY4s4JxQdmq
 QylGHYWXNIgEtmfBUSGz.Yq2fXvgSnU0sPdyFSABGGeXbMLHpjlpPr7kXatA5qtA1ZnJO0yym637
 G3bODCVNDy.1u7aH4dY_XIrkyP787tjPb7VmbFe2tiRbIMwWUnxzH7o7z_xuD9aIsyAbe3mqN58B
 LX09mrbaVoOb2QOzBUl8uN0WR2OVeshvkyGdkwJehWDz2B0Zh4njYbL_.DpJlAX_goRlJAN3GCAw
 BSJD40Af3MyHZn2Nkcdh1dtXCyP1_MEbHXV09BpPEnWv9s2GgkKfd7QB.ac.oXqS9k2j_xuNAs7W
 SJtSO2esWpmTniS9YwrokmuMl.yZH_7j_sE3SahNDjwOhkS0s7Oaz.tF_616WP81rr6eZD8dpDP0
 nB.o.DBGQGsQMI_GxBXpIt7H9N6kLFww6DvuEvlgj_pnJY.TvIp4kREqYivD.XP0MDqFjMrgu37n
 F74TtVVK0Egd9ZtWyELh2HSBPLxtNyZ8B23avvayRiLEOI_QNagZuUA6iY71GD8Pa64IF7Mn6V3x
 VGZL0V0eY194olqFVSx6qfLHAqeE.LJdU7Vqv4gtPtHwo7FboLnGVFc2Mb56RY7A2wp19MAarkRO
 WlexUsZfog2wKbXQzboHt8a_N1xja9Ty_qX1bY4tchxU2AgYGFBDVwXemL5rzlR.QoqMlqADAKXn
 9TTdH7Cpyq03oeucBzSPA7M3YW81bvGUHSIh3laO09P2sEzhr7gahOCKW4zy00I8_FY9eRgnyhgB
 _hXURiUk5YFqIZyP2m99_CkFCOksTjbDaemzf7Dg.vdFco1Ha_DU4VP5p.JpuDNAmqivBMhW.d9n
 Ts1zWvcDv7v1lOIEWzxllYGvyommERZKSI94zN4ihxTKkyI5zK9z2FrrTcEA9X0qNtF4uoOI9OZg
 o_NuVBnlSUIaKIkiNtk58oGnsIrZz9WsfBZ6QHFvafZs8FRN2H5fs0iA3tNgCAZOwlqXfF6XXEbR
 rksKSSbiuf0KGDuKLpobBdUP.0Zdg6eO9tFF0ZmDamVThEp8XtaabA9Cfa7HlLDKVeD68yqQkT_o
 JAaJeO1cj4ePvyM9VqVctEQUC3lk9NGX2WZ0etihRGaKNsysKLNmUCQjsDZu48HblqDAAbvRiHzD
 BMMXY3MiGOCn5VAXVnaS4PRDIPSuidEFotmWntQUGEhjEytX6gX9q3nZXlLodJVWxQROV58V674B
 8zAOkCaIX.5k9nV.68Qi3Sl0goBaliWsNztlGmu9osnE79BAuUuteLplFx9zDQTIsWWeLzk7dGz8
 490TtllmYZXUIkXxyxdkvuwW66yMol1.7DCdy8Bp82D7fm1KIXlTNeYW3vALhUfWBo5O5LIlOHgm
 X2h8ItadGg3aBSKhBvSGK6Gd4zUyw2tELjAPH77cAJjGJzilKLxEHr4EHsHQpUu7oza.uy7ejl7B
 uxXEkzPtXAcud5fuN1Zy4sisOasoGQqAn2Dz8nFjFwrCFyFIe03rvkRciogWkY5DEaixc2lBZnpx
 79uWv5rpBIcRfQtMO9LDWlbfBKTZfccQ3PbXNldv1nBackhuWMxrei81A8KuJ9doHA01RUmhfW0d
 245BeBMEmSxHebeMh2c4M7FB8Vp9AT4B9NsPa4Re5bVlEH77i9nyquh5G1AFKAGAWl9xThObfcdR
 LG4JOXVWSuZLR9VJ6ZaEQnoc02pUUOp7IddqyvbSYy_9tfcEN7sx0uoDkWT4L4YjqdJ69Hophpmu
 8CGFwIWSqcbHHSxomgBLNpjhz7qfsl92rjhI2KiQhjxbszouT9P4YE5AVgtmXiZBSv0PKx9_Tyab
 sRApncQtKNg7ssmSNxFUtn8jIKzcXhYK6BNH6IcB4Oc5d.ZLJccXPbHKH9IZypoD2bCksgLHNuF5
 np_O1cGgj00al7CtKt0u2uvXtN7ArsYXzuPcOYmCgSLcsYkLcE.4OCr1ODMrFs0gKNweCKdZnQdO
 eRiHZe0H6WZoLMV7pUPsZeu3rJT61COaqDBvO0FvMs7mWdPSfQWAq0.dS8_ACff.pnLk4lYtrTii
 Oysb3GHeezobqRACTLOHalgDVVFSATB0M98H273sjXmdpmBSaefHqDhx7Cg--
X-Sonic-MF: <jonathan.kuehn@aol.com>
X-Sonic-ID: 2381a4b8-e641-4210-9654-fdf5544e8e69
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.ir2.yahoo.com with HTTP; Thu, 5 Nov 2026 20:31:12 +0000
Received: by hermes--production-ir2-5dd9bf4598-nbdmm (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID 427936494fe7d05d5ede1876d078ebea; 
 Thu, 05 Nov 2026 20:29:11 +0000 (UTC)
From: Jonathan Kuehn <jonathan.kuehn@aol.com>
To: lyude@redhat.com
Cc: dakr@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 airlied@redhat.com, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jonathan Kuehn <jonathan.kuehn@aol.com>
Subject: [PATCH] GPU: drm: nouveau: Prevent kernel oops on missing firmware
 binary
Date: Thu,  5 Nov 2026 21:27:57 +0100
Message-ID: <20261105202757.28703-1-jonathan.kuehn@aol.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
References: <20261105202757.28703-1-jonathan.kuehn.ref@aol.com>
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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

Prevent null pointer dereference at the call of
nouveau_abi16_ioctl_getparams with parameter
NOUVEAU_GETPARAM_GRAPH_UNITS when firmware binaries are missing.
Fixes crash for certain user-space applications (steamwebhelper,
signal-desktop).

Signed-off-by: Jonathan Kuehn <jonathan.kuehn@aol.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/base.c
index cd4908b1b4df..9abeb9732406 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/base.c
@@ -72,7 +72,7 @@ nvkm_gr_tile(struct nvkm_engine *engine, int region, struct nvkm_fb_tile *tile)
 u64
 nvkm_gr_units(struct nvkm_gr *gr)
 {
-	if (gr->func->units)
+	if (gr && gr->func->units)
 		return gr->func->units(gr);
 	return 0;
 }
-- 
2.47.3

