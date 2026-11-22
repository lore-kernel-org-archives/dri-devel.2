Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCF5606A31D
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WsZLgjyS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QbgTPWNG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 018B910E623;
	Sun, 22 Nov 2026 19:33:40 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B31610E623
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 19:33:28 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AMGUx76412168
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 19:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wfDQkUDoBWgh6NvrfsXrMIRUmVcfOkBtNB6Z/9Xex1E=; b=WsZLgjySi4NZ6DM4
 C4lEyjUg9jh9P0CH7oIwb1SnQRdQl4K6etiNR13OvxYW/Kay2W0bvjmegDpGQw1g
 0LIvo1RD0RUixtrWBfGRS2ZvrmCQqvz3q8Lc2RzMzZ2iurSPlDYUs+ORgzhoZqLF
 3jMhb6nGCDV7C4RkDvhqty2hBiIIo4Mm5hzhPz+M0TQR3FnuRaM0kJzXH6JjLqRL
 buE+rSuXZ59a2i0oFPpav4P+k5xglw4xO/mh8IJYQBSeXijwo0mFq3iE5hylJ/Ve
 GuUkpCATOGu4hNkd7NuSWSXnWOjs9Zm0WlQ2iWOTjm3kL2lSONQtmF7V9q6QJfqJ
 W8fGsw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32a6m5rw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 19:33:26 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-386ad819860so1089092eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 11:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795376006; x=1795980806;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wfDQkUDoBWgh6NvrfsXrMIRUmVcfOkBtNB6Z/9Xex1E=;
 b=QbgTPWNG00TZ/H0iTrFL2+oBnFt1tyVl0XHV/osqVNhYD/ksxIIIETz9KsbrxhSWin
 cxDaG1zyKgjTWYejuRY2Rf9xKgWYwmUDk0dvADNWeZBylyNuN+c6KkbrzqXoXm0IxZdI
 lLJYJWFo2r9Qpl/A4gvdYw6imTs+yY4MsBq9h8sqr94IwmOaaKmUKYAF8bI81ov4hTOE
 up9+GYN23I6wEpxYkVEanW/OYr8TuqzfOj6QOWNVtbC6/WTkpL+NnKl2dshLcmTIo8XR
 x2VARdkH2/FpnBfBlG4DPdghIH+D4qg5NVODi9cuKJgqNJY71M8J3PPvi7DNHDZMRRsO
 XhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795376006; x=1795980806;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wfDQkUDoBWgh6NvrfsXrMIRUmVcfOkBtNB6Z/9Xex1E=;
 b=u6YVO+mSj3zJza5RjAHO7T3wNYXZYMZMcmdBNOaSWUviuomahWA/6w5BFP3w9s4J/F
 +ArJJGMjoQkYVRfJBU+UgtFiYcn7EeXCWQ9wbIZY1oO3dhFznFve6OgnpjdN7T5mmdWN
 JZmeWp6MM0vxCDn96kZvDjtlZuF+ohPrGck9jg7pGwWb2n6yvCCvUIBYbEY2rg6bZBVT
 hfSXtHYECKHXc241+R1aXtG3Wocg3Y8r/R7B0Yjasjxj5+UWXrRE/YFRjzAklZFVF8gc
 oJVXvGFgIXXoBs0/g6C3Z8/O7qfHsMw08UrZxKcZ7jYIYFwRcc7g1fulO9AZlWw2k/t2
 l/vQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHKO9onFLqoCgNUAoz6ItJ3zzdeFGDLZRIa1O6AGlcQueE01awRPIfUcTNvXIGenQq0FOZWaq1n1pE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9SG5iARGwQ+e34w93woDJGYKyeyUC5IIqw4OP2QaN0MWGwVdwA
 VfIMRL5JoB4elvYbv0xEg1vDmmUldohG9VFO13xDpdYjtYb9VAQyn+XiwZEFK077oke0tJdqcFc
 r36vDvbznzSxgV3D5fYFWAwJNQuwA2HLnn+HjNj5KkHk0U/ZrhID5ylYTMOJ/WEpnDTH8fMQ=
X-Gm-Gg: AZFdTZeAMS11L04AOsEx9zfbtMSGMgrkcxh++5V3HTwSZwg6QHcmgb2GxdYYvVNQmov
 s88z1zbTVIiB8T4SJkaqoFYcFVDtrQcimLBcV06vVMLnvBGQ6Zr95WrUZa5KEn2sQUByofA9ATp
 4/tdvi2Vs558rLsEk1xNF1cK/3xe47nLpv2e2SpZPXQ9jmXESX0tCYBTzDI5tR2ndCkhmJO6bKS
 U1e1W0/0xJdCcRKZ+niVoMyd2wKRRJClI6UaGEHjNXFfLl6GZEdM4LD4M6xTuXh/gTutxzEC7pg
 4qtsNa7VFw8yj2rYJ4f/qAsMdThRXVbk8Do8BDfx6VhCCfsroEa/aqOnbFv5jYh8p74Z4SDz4Rv
 OCOFg89c0BcMyijo9beXeeu5/UaIP3E0HhmquaAk1j6nac3GgFmyWvbao6o4m680KkVVue7Yr3g
 ==
X-Received: by 2002:a05:7301:182f:b0:385:cf42:9b9b with SMTP id
 5a478bee46e88-385cf429e7amr9674098eec.8.1795376005782; 
 Sun, 22 Nov 2026 11:33:25 -0800 (PST)
X-Received: by 2002:a05:7301:182f:b0:385:cf42:9b9b with SMTP id
 5a478bee46e88-385cf429e7amr9674050eec.8.1795376005141; 
 Sun, 22 Nov 2026 11:33:25 -0800 (PST)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386aaae4960sm6160806eec.18.2026.11.22.11.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 11:33:24 -0800 (PST)
Date: Mon, 23 Nov 2026 01:03:19 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v17 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <awNDf00s/ZUYtnnZ@hu-mdsor-hyd.qualcomm.com>
References: <20261008-lt9611c-v7-v17-0-1e8f5f2b2f19@oss.qualcomm.com>
 <20261008-lt9611c-v7-v17-2-1e8f5f2b2f19@oss.qualcomm.com>
 <sashiko-outbox-163341@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-163341@kernel.org>
X-Proofpoint-GUID: ZlxjZji3hu5F9dSB2nnPJ1BlXPWIxgV9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDA3NyBTYWx0ZWRfX/yfN7+2TLluD
 xg6DHJx+enH/r9M6MPGP0EsVau8QfsMyY2nS1/otivalD82bPepzcOhe8lJQDPQtsxcUhth8og2
 QAgCvkRVdjsEOx8SgwSjzoBkPMtYY2k=
X-Proofpoint-ORIG-GUID: ZlxjZji3hu5F9dSB2nnPJ1BlXPWIxgV9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDA3NyBTYWx0ZWRfXxGzgF47X4EZQ
 cu2NnoymOmpU4kN+uRU2G5BlCP+nXwLrcmKXxncKSFO8Ha4UbgHhx8murzM7BJDkRYszCzr7vhN
 aBsLAPIdsYLvbzEuDVEjYAM8m747ORpWWg2IHH46S+r5J1AUzrbnp6Wxi+i7IyHEVwqK6iSR2Fo
 arYYyaCKOntbNjtFpkTetllIFdE/MaxZNeb3QwbBD/TJCciGnx0iwodoAYRcaJ79EOD4kslf2qO
 cB3RL6AtN2o3lf4JKir4+aZL6q5wdGRgdXlSx17ajp1lPO5yBn0CuSUdL16Kp4/PEwR8lfGhJEB
 7uKk6uVpi+b6AfkFjJWu2wDI9EkJiXHYSVONRXrC1AOCuRXL+BYjSsIi+g2FRFoGGVfBFnxSBa6
 CTK10KgRBih7DBetsKLWxYINyHdygzbmPlKM3oi8N/npwIgPkaiMlk2Jh9pKcV19RioxOm5IhtI
 Y0KIdIXpqwjdn9tdIgw==
X-Authority-Analysis: v=2.4 cv=UbHE26SN c=1 sm=1 tr=0 ts=6b034386 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Kz8-B0t5AAAA:8
 a=kDMPUpoz_E6gDt0g-SwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_04,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220077
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 07, 2026 at 08:32:56PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [Critical] drm: build failure due to non-existent .atomic_create_state hook in drm_bridge_funcs
> - [Critical] drm: type mismatch and memory corruption in atomic_enable hook signature
> - [High] drm: missing mandatory initialization for HDMI bridge operations
> - [High] sysfs: NULL pointer dereference in firmware attributes due to registration race
> - [Medium] drm/bridge: missing atomic_disable leaves LT9611C hardware powered on
> --
> 
> commit 0482492a2bb6e8ef5381a82384662e6858358155
> Author: Sunyun Yang <syyang@lontium.com>
> 
> drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI to HDMI driver
> 
> This commit adds support for the Lontium LT9611C series MIPI DSI to HDMI
> bridge chip. It supports configuring single or dual port DSI inputs and
> provides HDMI output functionality along with audio and sysfs firmware
> update support.
> 
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611c.c b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> > new file mode 100644
> > index 0000000000000..6082c89b388bf
> > --- /dev/null
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> [ ... ]
> > +static void lt9611c_bridge_atomic_enable(struct drm_bridge *bridge,
> > +					 struct drm_atomic_commit *state)
> > +{
> > +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> > +	struct drm_connector *connector;
> > +	struct drm_connector_state *conn_state;
> > +	struct drm_crtc_state *crtc_state;
> > +	struct drm_display_mode *mode;
> > +	int ret;
> > +
> > +	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
> 
> [Severity: Critical]
> Does the signature of this atomic_enable hook match what the DRM core expects?
> 
> The atomic_enable hook in drm_bridge_funcs expects the second argument to be
> a struct drm_bridge_state pointer for the old bridge state. Treating this
> argument as the top-level struct drm_atomic_commit pointer and passing it to
> drm_atomic_get_new_connector_for_encoder() casts the bridge state to a commit
> state, which can cause out-of-bounds memory access when dereferencing the
> state arrays.
Will be fixed in next version
> 
> [ ... ]
> > +static const struct drm_bridge_funcs lt9611c_bridge_funcs = {
> > +	.attach = lt9611c_bridge_attach,
> > +	.detect = lt9611c_bridge_detect,
> > +	.edid_read = lt9611c_bridge_edid_read,
> > +	.atomic_enable = lt9611c_bridge_atomic_enable,
> > +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> 
> [Severity: Medium]
> Is an atomic_disable hook needed here to properly power down the bridge?
> 
> The driver implements atomic_enable to set up video timings and dual DSI
> ports, but lacks a corresponding atomic_disable. During display blanking
> or system DPMS off, the hardware might remain active, wasting power or
> potentially locking up when the upstream DSI host stops its clock.
> 
> > +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> > +	.atomic_create_state = drm_atomic_helper_bridge_create_state,
> 
> [Severity: Critical]
> Does this compile against the current drm_bridge_funcs definition?
> 
> The struct drm_bridge_funcs does not contain an atomic_create_state member,
> and the assigned helper drm_atomic_helper_bridge_create_state does not exist.
> The correct hook for resetting bridge state is atomic_reset, pointing to
> drm_atomic_helper_bridge_reset. Without a valid reset hook, atomic state
> allocation for the bridge will fail.
> 
> [ ... ]
Will be fixed in next version
> > +static ssize_t firmware_store(struct device *dev, struct device_attribute *attr,
> > +				      const char *buf, size_t len)
> > +{
> > +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	dev_warn(dev, "starting firmware upgrade — display will be disrupted\n");
> > +
> > +	ret = lt9611c_firmware_upgrade(lt9611c);
> 
> [Severity: High]
> Can lt9611c be NULL here if the sysfs file is accessed before probe completes?
> 
> The sysfs group is registered via lt9611c_driver.driver.dev_groups, which
> means the files are created by the driver core before probe runs. If userspace
> accesses this before i2c_set_clientdata() is called, dev_get_drvdata(dev)
> will return NULL, causing an immediate crash when it is passed to
> lt9611c_firmware_upgrade().
> 
Will be fixed in next version
> [ ... ]
> > +static ssize_t firmware_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> > +
> > +	return sysfs_emit(buf, "0x%04x\n", READ_ONCE(lt9611c->fw_version));
> > +}
> 
> [Severity: High]
> Similar to firmware_store, this will dereference a NULL lt9611c pointer if
> the sysfs attribute is read before the client data is set in probe, or if
> probe fails.
> 
Will be fixed in next version
> [ ... ]
> > +	lt9611c->bridge.of_node = client->dev.of_node;
> > +	lt9611c->bridge.ops = DRM_BRIDGE_OP_DETECT |
> > +			DRM_BRIDGE_OP_EDID |
> > +			DRM_BRIDGE_OP_HPD |
> > +			DRM_BRIDGE_OP_HDMI |
> > +			DRM_BRIDGE_OP_HDMI_AUDIO;
> > +	lt9611c->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
> 
> [Severity: High]
> Since this driver sets the DRM_BRIDGE_OP_HDMI flag, does it also need to
> initialize supported_hdmi_ver, supported_formats, and max_bpc?
> 
> When DRM_BRIDGE_OP_HDMI is set, leaving these uninitialized (zero) causes
> drm_bridge_add() to log a warning for an unknown HDMI version. The HDMI state
> helpers will also reject display modes because no valid color formats or
> depths are advertised, which prevents display modesetting.
> 
Will be fixed in next version
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261008-lt9611c-v7-v17-0-1e8f5f2b2f19@oss.qualcomm.com?part=2
