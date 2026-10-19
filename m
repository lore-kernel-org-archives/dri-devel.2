Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAA1CCF2DE
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 422E310ED0F;
	Mon, 19 Oct 2026 13:12:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3780A10E5BF
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:44 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8PB6G2236447
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=eZdHwhy+tZUtldliAHZkiD
 6+tXaEfKOXU8zCpoI4PEE=; b=SM0pYlzjVq1J92qrFLEzWR2wWwcH/kIYt51v5u
 FPaIathqg62NtQ9QmzjXbtZgae8EawHURY8IluOvebY5Jd6XoR9zxMeyjsDyahq4
 EqsSFRLBiAxMT4cKIq8V4GqkDpE8nmN2e6rePEBmcqFMW99PKRs01fDMb0fTbu3b
 C7c7zgTkabwS6/yBhZm2x5EWjebigEuqiLR/DJ/7AphObI/t812D/QUvwjvW63Td
 gMHODYl3EuvPLCg5YkNO0QcrlOVHmMxlfCZAj+3LkxzBvzOLYw3hHg+r4GrHK4vq
 umaUwtBbhEHuMRfX8NB/03TjoWeQiyko5nlyVnFI1oKZT8PA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3x984y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 13:12:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93909014c85so475828685a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792415563; x=1793020363;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eZdHwhy+tZUtldliAHZkiD6+tXaEfKOXU8zCpoI4PEE=;
 b=G9YpMdX7FyJH2Hx6ckeW+ut027ZK7Hb+9Jx4V5Th1sIWGhl+2PPEBnprbYkC5eBm8q
 bYZby4XIcYaI1ZJDHhZR6i4ZY+UV9JzAFn1V49WvyV5hsO8rHsJuyX5F7WJET+9doDqF
 Yh4UMkmHsO3GuEQ349MVk7sU0Sj1r4VCKY4dg2mG2a5Y337/c82FpmYqkdMsX7YnLj7i
 IUipK1YwI2i5Z2syABXj6cSNVNtbx3EnPRCtZotR55mzTHsIq30QwiJJrqh1Nz5shFgS
 isunnxXlmJaKWIZG/pl4iCzAv8QdPjHUBh5DZAVgCvhRL3YhL84Q7HbTMiKuH09m6lXX
 I6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415563; x=1793020363;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eZdHwhy+tZUtldliAHZkiD6+tXaEfKOXU8zCpoI4PEE=;
 b=m4j/wSZ/0L00VBVRs5TGO1YQ7v/bL29sXmS05bkFfp/02kIUbWpjczpybs4EHqOOnP
 vNqkyhmupXRKDnQwaiDfTEKnAPKuqJfbbUPyheDKbO8gpJiUlS5eyHiDcIkFMcLRmA5B
 nYqStmO3vqi/ZqPK6qnrXQG1+yPJGmGXpEOXb2HtDHW002Iy6bcDMMeBmb2KRxAVgP6V
 6iq/sOElX/ZdYayrUC9Nvi+Uw1Y/1NPClQwjW92yfeNFmMg1B5kcENPYziYgaYLH8WrI
 6xxYTYGmZq1c3JlNG0GP//Mr6vPa7l85VpUluZA1QUnSk0rJBewYXEK2BB7jh4c2P0VZ
 aNxA==
X-Gm-Message-State: AFq9FYIcJFJba4coLFnxATcL/4elayiAlc0rblh8+xG3r/IOev2MB1LD
 MAMGlAbCpXHJu26njig7deo/ljQJihwAcR9H7lHVBFhP7x/rjPSEwI2MwYfj3XPBuFAqU93A+eO
 G0tMPowLcwBnDAzzRizhfZeyff/kZYOoN+8eUutqfCEeTsnsgUtSX5E5T+VEzqQwvbLvCem8=
X-Gm-Gg: AYBFou3/5mvOMKpkWXEtQ/wJVe++6EGZJ272IwQH92W62cDdSdiF0f+zaitJBv17yah
 HgvgDshEfNiwzD96H611r0tNCng3MxYtdhvBUCHrtT7g+LBvqhYUAnTxqFs11/456DGD2m4hkxm
 Lex0plhOkpl3lY4gXECN+ggRHnz6mHNv/t51zU1mh0oBXSz4Kr/2xgsv+4ruL2WypShAmTQGEH+
 9pyEG0L8CgVWfVBbIKP+FpfXRtYjLkv7X0mOerkOHqStXtWrWKSOdICW4CTf5j3r8x2o9UO9yx6
 +exS8iPOwbGIscP8Tgt7GJDoCbYtff5AiZGuFZhOSUQzjFW2SyalxYITVNtqLxgvVoUsduO5J1b
 8hCbav+nccAOB3cWnms3r7ZLZmoGDr9SUS6HNJTpS4o0IhZKiom5PeC/Ad5zYlywPffuMgeRNE5
 fPtg5cmkVhH+gs
X-Received: by 2002:a05:620a:170e:b0:93e:9292:1b9e with SMTP id
 af79cd13be357-93f29b61deamr1133243985a.1.1792415562646; 
 Mon, 19 Oct 2026 06:12:42 -0700 (PDT)
X-Received: by 2002:a05:620a:170e:b0:93e:9292:1b9e with SMTP id
 af79cd13be357-93f29b61deamr1133237185a.1.1792415562014; 
 Mon, 19 Oct 2026 06:12:42 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab24f5dd5esm23432581fa.6.2026.10.19.06.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:12:39 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v7 0/9] drm: writeback: clean up writeback connector
 initialization
Date: Mon, 19 Oct 2026 16:12:26 +0300
Message-Id: <20261019-wb-drop-encoder-v7-0-d4288a26eb54@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADoX1moC/3XSS27DIBAG4KtYrEs6YJ5Z5R5VF2CgQapNAo6bK
 srdixOljeR6g+ZHMx+L4YKKz9EXtG0uKPsplpiGGuRLg7q9GT48jq5mRIFyUEDwl8UupwP2Q5e
 cz1hLA53k1nEnUZ06ZB/i+Sa+vde8j2VM+fv2wETm23VrIhiwokwwAYwG6XaplM3xZD671Pebe
 qCZnOgTQ8SSoZUJmhPngQUW9ArTPjN6ybSVsUwZYYLU0NoVhv0yhFK1ZFhluHJUeSGUBrLC8Ac
 jgANfMrwyjHIhreykCXSFEX+MIHTJiMro0BrOgiItgX+Y632N2R9P9T+M910ia4rHc1Mct43LP
 e5j6V4fBR78eayj1x+FlAbJUgIAAA==
X-Change-ID: 20250801-wb-drop-encoder-97a0c75bd5d7
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Harrison <John.Harrison@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, Eric Anholt <eric@anholt.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Brian Starkey <brian.starkey@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Suraj Kandpal <suraj.kandpal@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5455;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=cowxUPuyfm7iX/U3438hUWkWdunMkg1NU1rCpZXy67E=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1hdA4l3vK2F1yt4ysfonHcK6dLFUN6EqI963u
 Rf6uvNhA/6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYXQAAKCRCLPIo+Aiko
 1QidCACxFXoJnJ0O+w7I2k6Z7dgIBx6xeWIB8R5h13KoJUqWp4ogxF8kES4j4QFdUu+pFQrsYUZ
 1SoyhkEovuZHyQPhla3RtKuE9RtYdZIYLz9wYSD0pXWepwBF1brNQ4QH/6BaMvCRRQb8c5GHopW
 Y8c6Jm9cULMKMSBGh+8KceVLw74vPvvtaIivE7xPc00MKfGNE35UtOVCLf3FwYMSoNK8n8wGJes
 1KgYfFHipxKt14NEQnycK1PvQoQ6Xoq4TRdYTHA5QKokxrlRlAhssIHsK+qc1/QSbiUOa+Tmz4D
 x3JB84ibbSjuY5K9Wry3HBPHY+yjLT6AQpiw+FCOue45xUpG
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: fSL4oanldtdDXyrDKLe1JZh8dsT_nfqa
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXyPYFDyGTEemI
 4Kmdf3y7YNduxjT1Bf1D8uFO/+Wl4R4ujr8LIxkoy9Wee23+6s+anhF5CiLjijsqquV3KS021hj
 1d3ojHtaFqBvcSJlsqfGS+xQvJEU8Lg=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad6174b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
 a=V2sgnzSHAAAA:8 a=zd2uoN0lAAAA:8 a=7CQSdrXTAAAA:8 a=P1BnusSwAAAA:8
 a=RF00TdSWAAAA:8 a=P-IC7800AAAA:8 a=-VAfIpHNAAAA:8 a=e5mUnYsNAAAA:8
 a=wUE-LUHtHEr0u8wc4aUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22 a=Z31ocT7rh6aUJxSkT1EX:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=D0XLA9XvdZm18NrgonBM:22 a=_nx8FpPT0le-2JWwMI5O:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=srlwD-8ojaedGGhPAyx8:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: fSL4oanldtdDXyrDKLe1JZh8dsT_nfqa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX7uiLVE/iLF5m
 g+z+gMwTqtA7TfcNHxMCS8W26ZF4ZWRpRCz0dQXdL44WKbytfSk5t/101YngD4XbJ3+IU5lLy++
 rIqZ38by5VXF1a7w+qfTaMy8TMc7VeEGTkPZRxp9qqE1Yi5V0fRTf2RwWvGOnqrYIsnHNQKaSgo
 KXAD+SkCb0ECVgZSY4Qwyd2THTKt2yWKnHsp3H++3ON5KeStox8pQFmlT3uxjVqN4tXBCHWE0iu
 t+99XnAykOXgUcawynv89TgG0DVL1ncbRmMqVxsAJuAf69QkvGWEv6UoklHWH8zreR7FAWh8Oth
 f1lyuQqAGViGme5xevHv23IVDD7+NTx2RlVDrGz01SlQMew8LNA45kOi74XGFvUaMX5KNMXqOSc
 3r65Gzx/lT0ILoZoeLJ4/jz+AtOG4815eeIAP7ugvAJSfyldpFYlw+BK/XyQrVJ3yTiYroQbKTV
 OwYDGBuuc9hrC20rHqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190052
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

Drivers using drm_writeback_connector_init() / _with_encoder() don't
perform cleanup in a manner similar to drmm_writeback_connector_init()
(see drm_writeback_connector_cleanup()). Enough of the drivers don't use
the encoder embedded into the drm_writeback connector.  In preparation
to further rework of the WB connectors (as planned to enable WB for i915
/ xe drivers, which would move drm_writeback_connector to be a field
inside drm_connector instead of subclassing it) remove the drm_encoder
wrapped in struct drm_writeback_connector. Rename the
drm_writeback_connector_init_with_encoder() to
drm_writeback_connector_init()
and copy drmm_writeback_connector_init() interface. Then, with the
encoder being gone, handle proper cleanup of writeback data in
drm_connector_cleanup().

---
Changes in v7:
- Significantly reworked series, no longer insisting on using drmm.
- Link to v6: https://patch.msgid.link/20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com

Changes in v6:
- Dropped applied patch
- Implemented suggestion by Alex to use drmm allocation for the
  writeback connector.
- Link to v5: https://patch.msgid.link/20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com

Changes in v5:
- Rebased on top of drm-misc-next
- Expanded commit message for msm patch, describing devm vs drmm issues (Laurent)
- Expanded commit messages, describing why the drivers are converted to
  drmm_writeback_connector_init() (Laurent)
- Link to v4: https://lore.kernel.org/r/20251228-wb-drop-encoder-v4-0-58d28e668901@oss.qualcomm.com

Changes in v4:
- Rebase on top of drm-misc-next, dropping applied patch.
- Added a note regarding memory leak in the AMDGPU driver.
- Fixed a devm vs drmm issue in the msm/dpu driver.
- Link to v3: https://lore.kernel.org/r/20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com

Changes in v3:
- Fixed subject prefix for the rcar-du patch (Jessica Zhang)
- Link to v2: https://lore.kernel.org/r/20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com

Changes in v2:
- Switched to drm_crtc_mask() where applicable (Louis Chauvet)
- Link to v1: https://lore.kernel.org/r/20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com

To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: John Harrison <John.Harrison@igalia.com>
To: Harry Wentland <harry.wentland@amd.com>
To: Leo Li <sunpeng.li@amd.com>
To: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
To: Christian König <christian.koenig@amd.com>
To: Liviu Dudau <liviu.dudau@arm.com>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
To: Magnus Damm <magnus.damm@gmail.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Maíra Canal <mcanal@igalia.com>
To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
To: Mihail Atanassov <mihail.atanassov@arm.com>
To: Eric Anholt <eric@anholt.net>
To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Brian Starkey <brian.starkey@arm.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org

---
Dmitry Baryshkov (9):
      drm/amd/display: embed the writeback encoder in amdgpu_dm_wb_connector
      drm/komeda: embed the writeback encoder in komeda_wb_connector
      drm/mali: embed the writeback encoder in malidp_drm
      drm: renesas: rcar-du: embed the writeback encoder in rcar_du_crtc
      drm: writeback: drop excess connector initialization functions
      drm: writeback: rename drm_writeback_connector_init_with_encoder()
      drm: writeback: don't destroy the shared writeback properties
      drm: writeback: clean up writeback connectors in drm_connector_cleanup()
      drm: writeback: drop the drmm writeback cleanup action

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  27 +++-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_test.c   |   4 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    |   4 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.h    |   3 +
 .../drm/arm/display/komeda/komeda_wb_connector.c   |  24 +++-
 drivers/gpu/drm/arm/malidp_drv.h                   |   1 +
 drivers/gpu/drm/arm/malidp_mw.c                    |  25 +++-
 drivers/gpu/drm/drm_connector.c                    |   3 +
 drivers/gpu/drm/drm_crtc_internal.h                |   3 +
 drivers/gpu/drm/drm_writeback.c                    | 147 +++++----------------
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h     |   2 +
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    |  29 +++-
 drivers/gpu/drm/vc4/vc4_txp.c                      |   8 +-
 include/drm/drm_writeback.h                        |  22 +--
 16 files changed, 140 insertions(+), 165 deletions(-)
---
base-commit: 725953d4da85cfb97a4c309fad6346b72f8529e7
change-id: 20250801-wb-drop-encoder-97a0c75bd5d7

Best regards,
--  
With best wishes
Dmitry

