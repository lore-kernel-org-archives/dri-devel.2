Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49BC606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B05AQ//3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e/SqYR9E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E6310EB79;
	Tue, 20 Oct 2026 11:23:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7EDA10EB79
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 11:23:29 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KAxZHi927001
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 11:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qhh0ZV45FGIUTeIwsmsxV4mxFb/EQ7WWA7zG32iYPew=; b=B05AQ//3bin4597i
 8GD/kjSrr0VfInVU74gSPlE9m04Eh9WHk19sJCGQunDEY+DJgCFZtdfgZ+SeGadw
 LXDJDBd8djPjp0Lu2UQQjst3x0OeE50hedLwWFjiR2NqOGCphCKhtIDlYJRwU51l
 R3yovryvY+oXf8J1BmPNZhz3v/rvkJm79FUqenDj6oAo5B/mxfCDZjaFwLf21Kpc
 xlCBZ1zK+oGNX60eRFdk9y7WR2MkbwS6XJT8td2yS0fXxMz+WenZDlk4dQsXWWq+
 knyXHi6yhLXXdF4PzW7OHfhQ3tCzBh0yCYpeaHGreI2MpDCJTNwkzijNqwPoSxf5
 pUKJjw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5pa8ew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 11:23:29 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso4654644eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 04:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792495409; x=1793100209;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qhh0ZV45FGIUTeIwsmsxV4mxFb/EQ7WWA7zG32iYPew=;
 b=e/SqYR9EXiTN6+tnpi+5oRXhX6mNM48GClPwiM3QcPUxaJaeIWOJv4X6Pjt2lhkw+S
 n7wyj+3C5O3YFV5Ey80c39ufpuvmybbUA2YEPeCMfPPu5If/oYgwPTQK7DcvpM5OaC75
 y/y/FJ5fySfm4Kf6QtjuSCEGM9MA+tcChY5PZiwy5YpeucPduR06BDjplmUB7pk+ab4n
 p2SYz39szEYgO9dF3+UL2XDtpXKzozfyXPvPX9oxfZcAZW41anBAgkcnRYyo4ku1mKZO
 ogbLHvqOAzOy+3+I/pgV6R61M7nzsoy7suy0Cdgcem1ofdCuz6oUqD6eIG2brcdVZnHW
 sFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792495409; x=1793100209;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qhh0ZV45FGIUTeIwsmsxV4mxFb/EQ7WWA7zG32iYPew=;
 b=uhgR60h9OeRByKvkPrwxFGN5+MOArJ/yReHfEq6XD002IrZU4itfBGw+qp5dlnb7IR
 WUmCn/J0UxliBGQzvJwj78Z4Aiz6kdO5hPjdpv8L9XtCKy/lu27ujyIRq99Lmr781sHt
 d1Wvl8CpNZ07w/yj9TNGbLAm2TU/cnaBDZa8a7ALrW2AE4urqkr74vDZmEyaAqiR34R8
 vttMBmOi5GeKjd4dIAbHbXcqAiUhzrRvKTCFqln52onK03VgAyldi6AsLGvPblD78iEI
 YMzT4Gq7ID+GhyB7KnSavvsrHWQJCRFsKMMCuTGi3GiSA4oWdD9HqX8f3xgumUHoeoLv
 OKSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJcBKpFn2BoA4pjUue2AvQBzdHd7ANiclYGuJLsYp99yr6cGUmViA+gEVANhRwxiuIsd5BE9QXUcw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJYw05slOQj2YvQQsHT3gYkc1zEQ/n2VY5yCFKlW2j7vKFpzXuz
 CJAhR1hA53gJle9CqMP6mioXe5UkjR74WT9vzA8Di4T1/ogKliKOX4wgR62LCDAyayIbT9MBuEh
 BZHgPfi/WhLRDosK14vnBhaWxo3EIqX5SadvaOeRMfIzJkCihLErRrzFFLMWY6rvuGwIuLx4=
X-Gm-Gg: AYBFou0GdRJYLLDxlLI8zzvpZxOYFOqC5ZK/1ScfeoC4NTCTRPn3nojTVSZUGxWRP1Z
 FiieW95b0g5hWIEbs6snqTmJeQD7oc+tVk7mzDqiqpTPac1hmZJFAPIrTvwZcSd9nH+IBR74RKs
 3wlCf5DQ4pEOvWLM/7cDM5F/qH7V+fWZU5v9wSXsZQfbIBSeOFB18cD1WYFhcFEAGgqHA85Axdj
 K4/zJnzu7UgadUFod1i0yruHxucNpB+CxQU0TmbEkutTDWBxjVgjx6yt/xI37pHAEY/9pQYZgwA
 I4+ZyQ2eS7Qdj2zLpVY0DduCnytZckG6YeAhYW9zd6nlTrpY9P2WavHWIlwU49GjrncFWIze0Xf
 zuOhuHrcnSn8ASa7y9Qxv/mFTbQ==
X-Received: by 2002:a05:693c:8092:b0:35d:8c3a:38a8 with SMTP id
 5a478bee46e88-361a2942646mr16312725eec.39.1792495408289; 
 Tue, 20 Oct 2026 04:23:28 -0700 (PDT)
X-Received: by 2002:a05:693c:8092:b0:35d:8c3a:38a8 with SMTP id
 5a478bee46e88-361a2942646mr16312690eec.39.1792495407584; 
 Tue, 20 Oct 2026 04:23:27 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b792bsm41575611eec.5.2026.10.20.04.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 04:23:27 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:53:21 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v17 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI DSI
 to HDMI driver
Message-ID: <atdPKccBp6CFiTzp@hu-mdsor-hyd.qualcomm.com>
References: <20261008-lt9611c-v7-v17-0-1e8f5f2b2f19@oss.qualcomm.com>
 <20261008-lt9611c-v7-v17-2-1e8f5f2b2f19@oss.qualcomm.com>
 <sashiko-outbox-163341@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-163341@kernel.org>
X-Proofpoint-GUID: MoGoW2mGD7YU7ZWi4worqliDHi2H3RGD
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad74f31 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Kz8-B0t5AAAA:8
 a=JYkXmYT7k6CsIRxL8okA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=GvGzcOZaWPEFPQC_NcjD:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0NSBTYWx0ZWRfX+/430iZ6g1rD
 vAtay8Jy7eL4ns2awmQWfX7aGJ+SbpfzKd8oRiIpxm/2QqVXgrfFHCNr9CWjjxtEWLt3e8o9S9a
 cAE32YQ+dY8KpUQHOhAuD/nkQ9Xer1ijRHYm7TWYeG+qdMVL118iI7rdTZVu6/4fdwcUTOTfbPH
 RUUkoY3N776U+UQWClC9iBEDotZbpE+d74HumbHiUPtFH2Q9ble6rvk1JALkIxfkxrNEu7oAK9n
 7ToNQQZq3poAIVjObDRYOINwYyN/OiXNIyhUp3QwfeEMh7jRQTvKLr+XJaqM/hIuD9c+oFwS0yY
 3W7sr1qw/zxbQ6HA8VnDcj0GplIrmuJ/HdtGEZZdB251Pk5lDBQyVNrbZgq8BGcMsqV+lMxSzR1
 u91rYzA53r+0dgRmor33b/1xzJnYrpYgvFMvxQTepm7tkmudCpqhy+gd1zUFe02qplA+voOwNHH
 tvkiv8umxrJds5PT9Pg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0NSBTYWx0ZWRfX+lUi/jaM4lO2
 o8l4Wkpr/C9L0o/JrmbFXyZ3Yzm7roYVfsP6vNI2jGx9RLE7WpuQm+K/BWYQFaclHRZYa1wHIRe
 ZVVWDhPdJux+eTPENTfXosHkdZOm9Mw=
X-Proofpoint-ORIG-GUID: MoGoW2mGD7YU7ZWi4worqliDHi2H3RGD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200045
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
The atomic_enable hook in this kernel tree (include/drm/drm_bridge.h:339) takes a struct drm_atomic_commit *, while drm_atomic_get_new_connector_for_encoder() expects a const struct drm_atomic_commit *; therefore, the usage is correct, type-safe, and does not require any cast.
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
The LT9611C bridge does not require an atomic_disable hook for correct operation. The bridge MCU firmware manages its own state and automatically enters a low-power idle state when the DSI input clock is removed, i.e. when the upstream DSI host stops transmitting. Explicit power-down via an MCU command is therefore unnecessary and would require an additional MCU command sequence that could potentially race with DSI host shutdown.

System-level power management is handled by lt9611c_bridge_suspend(), which disables the regulators and IRQ, while display blanking/DPMS is naturally handled by the upstream DSI host stopping its output.

If a future use case requires explicit bridge shutdown between mode transitions, an atomic_disable hook can be added at that time. 
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
atomic_create_state is a valid member of struct drm_bridge_funcs in this kernel (see include/drm/drm_bridge.h:507), and drm_atomic_helper_bridge_create_state is the corresponding helper (see drivers/gpu/drm/drm_atomic_state_helper.c:909). This pattern is already used by other drivers in the same tree, such as chipone-icn6211.c. The atomic_reset hook you mentioned belongs to the older API; this driver correctly uses the newer atomic_create_state interface.
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
Will fix it
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
Will fix it
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
The driver works correctly without these fields for the following reasons:

supported_hdmi_ver - leaving this as HDMI_VERSION_UNKNOWN (0) only results in a DRM_WARN from drm_bridge_add() (drivers/gpu/drm/drm_bridge.c:464) and does not affect functionality. The only consequence is that ycbcr_420_allowed is evaluated as false, which is appropriate for this device since the LT9611C family does not support YCbCr 4:2:0 input.

supported_formats - leaving this field unset (0) also results in ycbcr_420_allowed = false. Display mode filtering is based on EDID-reported sink capabilities and does not directly depend on supported_formats. RGB modes are therefore unaffected.

max_bpc - leaving this at 0 effectively disables deep-color support, which is acceptable because the LT9611C firmware does not currently expose any mechanism for deep-color negotiation.

These fields can be populated in a follow-up once the hardware capabilities have been fully characterized, for example, whether the MCU firmware supports YCbCr output formats or deep-color modes. Until then, leaving them unset is preferable to advertising capabilities that may not actually be supported.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261008-lt9611c-v7-v17-0-1e8f5f2b2f19@oss.qualcomm.com?part=2
