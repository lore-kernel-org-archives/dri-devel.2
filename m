Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AB6CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:34:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E06510E53B;
	Fri,  9 Oct 2026 06:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="O5OYJq5r";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD3F010E53B
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 06:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1791527665; bh=buow+Gcpxvw5o+/UDiEWwnwuSAkxrK4r3F8O5wV8HqI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From:Subject:Reply-To;
 b=O5OYJq5rZ+Q3pA65xA9r1zZLY5T+Jd/Vhjh3m6qAIvyJJ0wYe3kzxOliP24MkoYjc11vMi4C1Bps1urQ+vMMRUN6FcJjVruRZxQPDy+BNn5ciZ+98tJ/zcTEICyMaRpJftDfEBwoBiTDy1KIR5QOKBDxwO9T40NmkxuzFTHBX9h+YkgYTZ9k2nxwylt+yLuinI6fL3rklEggxpRnKXJ7+J4nHt4FiQ9RvQ7hxRv40B46gQTyBIOKaNzLGMM6kHuq9cAlIiwyYMHXDmF6Gh228POx4H2LjtC5QyG9up14jjPM1T3JSnZ/MWtemJtk6YNP5Qvidwl3FUMHuMEAlY2GRw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1791527665; bh=ujmtQ6V7zYSv9FHjdsDe/ddFxmdfm8QD4uorEnN7j9a=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=jRwz7frJZfi4I/Z0hSQG0nfOodeRTIxE6iFa2h9/Pfyk33TG/Wi9pfEty2ftj/wJYy01HZMRQ+0kTfAMb/O1eCC1aoSp89fnJA+NMMoZ1QH07n05PHC+Qjvbgftb4X/ODzt2tv1Srdz9KQkKBy1Bm4zeWapgl/D+weZOrY4mcP8rz+i4+q+OENsLlqVYIcwZdORTNpRf2gKwVmnmfcv5xNzPxm+ff+LHJIDgAQ/+NAU36Ad6ca7IdFaW1D9Zjt0NYw2BiXQ92QtSqwBcQDaKn3aH46lyCwPxkIBWAFXF+TYpcCHrYy8Opsvr2knab/MJSgoTLCKVrWuzxrDL/gf41w==
X-YMail-OSG: JJFYgd4VM1mh7CqUw_YM40D.eNNzshWU0cnp96oeTdMNJdlP1xilBc6Z2C6TqH.
 r0skVgwzK6ztsSJOBqqslcUxf7jZNRCEBfM9O7.c5BwO5FpvFikcHB4G2VS30aUWbVcbJe.i6w5f
 i81EMnD.UVlXy6sNC_c3Hakczl4HaHjlFZarQGQvHLgy_uZu3MOrQzQHz7VsxIVXKKeAkiFajSqO
 mPd6ryOsXQXSoPd7tef7ks9_pnXGWzk_NDpk5whOWPkOcFefY9ZHw7kd_zGoOuXYippTu.xjXxHp
 CcUN_OZ59Pk.B.T8QYpzagd9hya08xfAvsUr0Ru48HZscIPHwjEKjYbDCeWj9Sfi3CGHou1b.xUv
 9gIyLUfo9mJUNfVRrv4lN9OIRc4AJCFrjHFDNcbmQHe.JFPqNNwH1KH3QAYUF0DE3tp4.xJ2qffY
 mCFgMA2L8eNmOc.5bVpojYMcZLKMjL8dVc2wusiZQ.ViGQsdisGa3mHtBiEN6SsOxU1rEH_HeZBp
 WhADcO5suLtXqQc9Wl9j0VeD1s9iugf7ePYg6O2zr1Arw5KG2t3RUzsoNL6QteXQ9FlKFbU4q0jM
 HEMnR_y17MAyMFQxUB9fqj7jjmaknZLRpzJKBL5azMtL_AXM1ckjPQIAIPrTwjEStlcLrk5V4mY2
 hFTb8YYT6UZki9a_Cze3G4XCJ70L6SDQkVkP6UlMdIVPgIns6CvPTGNc.BaRzHt5I36bbRi7K0B4
 spE.fGL0bevR0FvzIud1.Bfsc1Rlj33xRit.YrDruNhfZ9.C8g4qyhOa_qC3tYzDmSHGyybCsXje
 ZIbzsDeMBba_GNlNtD3FcUOQDlhuxr3L2LVQg5HXg5LibDp_GR3h4FzMC4nQnIcIesSmJEIzweVm
 ckKm8ZayPkMqGytQLK0Rl0l7amfrJ1v0ZMWXXT7LOtzlRtsxpcmdVRfwgi.MNUeOabhkluKbrYyc
 ZXRZGN4O3frQPYb2GJTbw5dvJRb2NaAd2MMXXqHlH.eKs_bYXgKS6QwrZElGsZf4ar3k8U8JCJBz
 XAlgwzuSfrP3nfMC5tloAGEnPfTmHGEQ50fzv86s1BdbVmOaOpYw7QXNPaY31QE5CTJeSLtY60gS
 6qc.SshVtzfYdopqDCyvjmXrokgJZdejnPFRnKw9.UOgveRYGZJYnC0uhbARR3cE_jlp_uGaHMoF
 DC6n4kxjsPR1hsZ9IP_iN.FEGElFfEQrIpwkc._ZqGH2PG4RLOiSJXOuHQUlvuk8tTR_VzaFYZNh
 EOTYw_LsDVwMef55ey3tfhGT3oyq7rioDuojX9Wj5iirrmDTi9OiB7UGKqIa4DI.pgIKG238Tiiu
 TSMr4_DW3mvrrX8uuymMMk95JN3OEEzVyrMsVC7e9wmy..fqk0JQRKHruDXmnMY6ivND7SJYEDx7
 TcL7b0sfcs8Bra5gFXN_YJK8sqjbGoglxzpc.TC.PNslYXc0YXarDBTNAsjooCrC9p2lUUF5LiBI
 oVdAGdhc1KDRHsLbY7bRZfU4wRLmwssy8IzwP9zi6JibjEpYstfX0Ov0A4cwLErfuUeevGZFZ0zr
 gKEYvaygwWC2wxmqVJUjIxAPsVbvQSFA_aemYnsNxHMzOrkQNDY4wzo5k4jtFFa7nfUpnedf.nZG
 HraDQfQuVusQNm5psGbFIgfus0xZeQfB0Pb7e3_XMjPhMnssn7OUW2mLwa4WzfCwOQnD3_J9dFTs
 0Qk.MpAHEpCNg122ZsJ4C3TQSYgGuY.jIh2soEtDJFowqzJoX6SBv4SvCWF_MGuctdPSL0a2CZsk
 RC2Vgss5ZjimJvJsATBBBrhRHn9ILXndnuQcAMq4XXGULJeL_5OQmfh7aHM2nXPQbT_sdebpB7PY
 FwjhHoLvvkDlTD38qTOq4xpKqbGnYC3BPiRnSbGoRTHI3zKyJmyyzrDOHgnEfDTFx3W1CEc.rkWQ
 yCmM2zcMLFlWy4XnGcxQO8i4ICoh3nUjMAn5kpipf10pCIfWu70tWTxi5aaZ8gNG8dx2eKZXvp52
 9ulKTxbYgckv0Nj6zPVocC9zQxDA-
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 69998273-dcb9-4025-a819-9304c4a39114
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-101 with HTTP;
 Fri, 9 Oct 2026 06:34:25 +0000
Received: from dip23.lsn.bf1.yahoo.com ([67.195.177.32])
 by hello (SMTP) with SMTP ID 1831e739fda8c4be29e1ca6ab9c9cda8;
 Fri, 09 Oct 2026 06:34:19 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, victoria@system76.com,
 sebastian.wick@redhat.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5 33/38] drm/vkms: Introduce configfs for connector EDID
In-Reply-To: <20260627-vkms-all-config-v5-33-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-33-854aa0840926@bootlin.com>
Date: Fri, 09 Oct 2026 03:34:13 -0300
Message-ID: <179152765301.1436711.460818115522063531@yahoo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Mailer: WebService/1.1.26668
 mail.core.serving.mcws.prd.acl:role.token.mcws.jsmtp.yahoo
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

Hi Louis,

Sashiko's review of this patch raised the race between an EDID write
and a probe, and edid_enabled changed at runtime. I ran both in QEMU
on your base commit with v5 applied; here is what they look like, with
two cases the review did not mention.

On Sat, 27 Jun 2026 05:30:50 +0200, Louis Chauvet wrote:
> +static ssize_t connector_edid_store(struct config_item *item,
> +				    const char *page, size_t count)
> +{
> +	struct vkms_configfs_connector *connector;
> +
> +	connector = connector_item_to_vkms_configfs_connector(item);
> +
> +	scoped_guard(mutex, &connector->dev->lock)
> +	{
> +		vkms_config_connector_set_edid(connector->config, page, count);

vkms_connector_read_block() reads connector_cfg->edid and edid_len
under mode_config.mutex only, not under this lock. With KASAN on and
the script at the end, which alternates a 128-byte and a 256-byte EDID
while sysfs probes the connector, KASAN reports:

  BUG: KASAN: slab-out-of-bounds in vkms_connector_read_block+0x82/0x90
  Read of size 128 at addr ffff8881027e0c80 by task vkms-edid-race./196
  ...
   vkms_connector_read_block+0x82/0x90
   edid_block_read+0x45/0x150
   _drm_do_get_edid+0x28e/0x500
   drm_edid_read_custom+0x56/0xa0
   vkms_conn_get_modes+0x108/0x160
   drm_helper_probe_single_connector_modes+0x571/0xd40
   status_store+0x34c/0x380
  ...
  Allocated by task 1326:
   __kasan_krealloc+0x5b/0x70
   krealloc_node_align_noprof+0x179/0x200
   connector_edid_store+0xd6/0x2b0
  ...
  The buggy address is located 128 bytes inside of
   allocated 256-byte region [ffff8881027e0c00, ffff8881027e0d00)

The probe checked the second block against the old length of 256
bytes, then copied it after krealloc() had shrunk the buffer to 128
bytes. The report came 11, 24 and 17 seconds after the start in three
runs.

This is probably one of the places you mentioned on 22 July [1]
("Maybe one RCU for the EDID"). The script is the kind of hammer you
asked for there, in case it helps with the rework or an IGT test.

> +	if (vkms_config_connector_get_edid_enabled(connector_cfg))
> +		drm_connector_attach_edid_property(&connector->base);

The DRM core already attaches the EDID property to every connector
type except Virtual and Writeback (__drm_connector_init()), and
vkms_connector_hot_add() does not attach it. Measured with
DRM_IOCTL_MODE_GETCONNECTOR and a 256-byte EDID that gives 12 modes:

- HDMI-A created with edid_enabled=1: the connector lists the EDID
  property twice.

- Virtual (the default type) created with edid_enabled=0, then
  edid_enabled=1 while the device is enabled: there is no EDID
  property, so drm_edid_connector_update() cannot store the blob, and
  drm_edid_connector_add_modes(), which reads the blob, adds nothing.
  The connector ends up with the probe helper's 1024x768 fallback, 5
  modes. On HDMI-A the same steps give the 12 modes.

- A dynamic Virtual connector with edid_enabled=1, enabled with the
  device: the same 5 modes and no EDID property.

- HDMI-A or Virtual created with edid_enabled=1, then edid_enabled=0:
  the modes go back to the no-EDID list, but the connector keeps the
  old 256-byte EDID blob, because the no-EDID branch of
  vkms_conn_get_modes() never calls drm_edid_connector_update(connector,
  NULL).

I tried attaching the property in vkms_connector_init() to Virtual
connectors only, whatever edid_enabled says, and calling
drm_edid_connector_update(connector, NULL) in the no-EDID branch. With
that, all four cases behave: the property is listed once, an EDID
enabled at runtime or on a dynamic connector gives its 12 modes, and
disabling it clears the blob. If edid_enabled=0 should rather keep a
Virtual connector without the property, the attach can move to
vkms_connector_init() under the edid_enabled test, with edid_enabled
changes refused while the device is enabled, as
connector_dynamic_store() does. I can send either as a fixup if you
want one.

Sashiko's point about memcpy() from a NULL edid in connector_edid_show()
stands as well.

[1] https://lore.kernel.org/dri-devel/3adb0a99-95c0-41dd-a701-efaff37e74b5@bootlin.com/

The script, as root, with two EDID files of 128 and 256 bytes (the
second with one extension block):

#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later
# vkms-edid-race.sh EDID128 EDID256 [SECONDS]: a VKMS connector's
# EDID rewritten through configfs while sysfs probes the connector.
# Needs root, configfs at /sys/kernel/config, VKMS with the v5 configfs
# series, and KASAN to see the result.
set -e
d=/sys/kernel/config/vkms/edid-race
mkdir $d $d/planes/p0 $d/crtcs/c0 $d/encoders/e0 $d/connectors/c0
echo 1 > $d/planes/p0/type
ln -s $d/crtcs/c0 $d/planes/p0/possible_crtcs/c0
ln -s $d/crtcs/c0 $d/encoders/e0/possible_crtcs/c0
ln -s $d/encoders/e0 $d/connectors/c0/possible_encoders/e0
echo 11 > $d/connectors/c0/type
cat "$2" > $d/connectors/c0/edid
echo 1 > $d/connectors/c0/edid_enabled
echo 1 > $d/enabled
for c in /sys/class/drm/card*; do
	case ${c##*/} in *-*) continue ;; esac
	n=$(readlink -f $c/device)
	if [ ${n##*/} = edid-race ]; then card=${c##*/}; fi
done
status=$(echo /sys/class/drm/$card-HDMI-A-*/status)
set +e
echo "vkms-edid-race: start" > /dev/kmsg
while :; do echo detect > $status; done &
r=$!
while :; do
	cat "$1" > $d/connectors/c0/edid
	cat "$2" > $d/connectors/c0/edid
done &
w=$!
sleep ${3:-60}
kill $r $w
dmesg | grep -A 40 "BUG: KASAN" || echo "no KASAN report in ${3:-60} s"

Thanks,
Daniel
