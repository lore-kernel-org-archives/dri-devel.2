Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D10606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=empyreal.works header.i=@empyreal.works header.a=rsa-sha256 header.s=protonmail2 header.b=BCPnZTlN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D3210F9E5;
	Wed, 25 Nov 2026 08:41:21 +0000 (UTC)
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D573710E097
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 01:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=empyreal.works;
 s=protonmail2; t=1795570854; x=1795830054;
 bh=Nr8AhD/JTXYY4nRgKW9w8rOfFqSdm8MOb29z4lUlrQU=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=BCPnZTlNkRnWBhS17tF34xhMehKjFjO1oN2blzAwsnORVQOt0tr8Sk02/fG3wnBrv
 3MLTLF9xuvrrzjVtSoXRZNAv/oF62zFjR/LlysHHuKxk/R3F17dT7TMwy3mnuwpsnW
 0tZEituom5ID4o/FIyzzCUzBjsTV3CIpdJCi6d20LXcO94fOFK/I1TZFca0piOB9Fa
 HUQ1d/FRn6Tc5vbWjHrPKyGjXOXGYgVe//BqyoI8VZ16aQjRg+6u1ydlQpWirakmoP
 rhNZQuriD0qvVeDTAEWQ47yGfgz+gqoFCpQItjvSvM7QEvDhUU+4/4pNisWawyJVa/
 P6Lx9Kzq+9zeA==
Date: Wed, 25 Nov 2026 01:40:49 +0000
To: Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>
From: Andrei Rusu de Castro <arc@empyreal.works>
Cc: Oded Gabbay <ogabbay@kernel.org>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [BUG] accel/amdxdna: Phoenix NPU unusable after a TDR,
 and unbinding it then deadlocks on dev_lock
Message-ID: <20261125-amdxdna-tdr-dev-lock-report-3b8e51c2@empyreal.works>
Feedback-ID: 182420409:user:proton
X-Pm-Message-ID: fabd76ec0ec40cd28e9acd98cda0a11ed6d21bcf
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 7.4-rc3 with a Ryzen 7 PRO 7840U (Phoenix NPU, 1022:1502, firmware
1502_00/npu_7.sbin), one command that ran past the 2 s TDR left the NPU
unusable until reboot, and unbinding the driver afterwards deadlocked.

The command's shim DMA waited on a FIFO that never filled. At the
timeout:

  amdxdna 0000:65:00.1: [drm] *ERROR* aie2_tdr_detect: TDR timeout detected
  amdxdna 0000:65:00.1: [drm] *ERROR* xdna_send_msg_wait: Wait for completi=
on timeout
  amdxdna 0000:65:00.1: [drm] aie2_destroy_context_req: Destroy context fai=
led, ret -62
  amdxdna 0000:65:00.1: [drm] *ERROR* aie2_hwctx_restart: Create hwctx fail=
ed, ret -19
  amdxdna 0000:65:00.1: [drm] *ERROR* aie2_set_runtime_cfg: Failed to set r=
untime config, ret -19
  amdxdna 0000:65:00.1: [drm] *ERROR* aie2_runtime_cfg: Set type 1 value 1 =
failed
  amdxdna 0000:65:00.1: [drm] *ERROR* aie2_suspend_fw: Failed to suspend fw=
, ret -19
  amdxdna 0000:65:00.1: [drm] *ERROR* aie2_mgmt_fw_fini: Suspend_fw failed
  amdxdna 0000:65:00.1: [drm] *ERROR* smu cmd 4 failed, 0xff
  amdxdna 0000:65:00.1: [drm] *ERROR* Power off failed, ret -22

After that, every DRM_IOCTL_AMDXDNA_CREATE_HWCTX and GET_INFO fails in
the runtime resume:

  amdxdna 0000:65:00.1: [drm] *ERROR* smu cmd 4 failed, 0xff
  amdxdna 0000:65:00.1: [drm] *ERROR* Access power failed, ret -22
  amdxdna 0000:65:00.1: [drm] *ERROR* aie2_hw_start: failed to init smu, re=
t -22
  amdxdna 0000:65:00.1: [drm] *ERROR* aie2_hw_resume: Start hardware failed=
, -22
  amdxdna 0000:65:00.1: [drm] *ERROR* amdxdna_pm_resume_get: Resume failed:=
 -22

From the code, the destroy-context timeout makes aie_send_mgmt_msg_wait()
destroy the management channel, so SUSPEND_FW and every later message
fail with -ENODEV, and aie2_hw_stop() asks the SMU to power off with the
firmware still running. The SMU answers 0xff, and since every resume
starts with that same power-off in aie_smu_init(), the device stays
dead until a reboot. Is a power-off with the firmware still running
expected to be refused, and is there an intended way back short of a
reboot?

Then "modprobe -r amdxdna" hung in D state (over 40 minutes) with:

  amdxdna_pm_resume+0x20/0x80 [amdxdna]
  __rpm_callback+0x9b/0x330
  rpm_resume+0x49b/0x680
  pm_runtime_forbid+0x49/0x60
  aie2_fini+0x12/0x30 [amdxdna]
  amdxdna_remove+0xc4/0xf0 [amdxdna]
  pci_device_remove+0x45/0xb0
  device_release_driver_internal+0x18c/0x2e0
  driver_detach+0x8f/0xd0
  bus_remove_driver+0x102/0x190
  pci_unregister_driver+0x1e/0xa0
  __se_sys_delete_module+0x294/0x450

pci_device_remove() tries to resume the device before .remove(), which
fails as above and leaves it suspended. amdxdna_remove() then takes
dev_lock and reaches pm_runtime_forbid() through aie2_fini() and
amdxdna_pm_fini(); forbid resumes the suspended device synchronously,
and amdxdna_pm_resume() blocks on the dev_lock its own task holds. The
resume callback has taken dev_lock since commit 1aa82181a3c2
("accel/amdxdna: Fix dead lock for suspend and resume"). Because the
task also holds the device lock, a reboot afterwards hung in
device_shutdown() and the machine needed a hard power-off.

The same lock order is in linux-next (20261120) and drm-misc-next,
where aie4_classic_fini() calls amdxdna_pm_fini() the same way. I
haven't tested whether commit 8e2afcd2b579 ("accel/amdxdna: Fix SMU
command execution on platforms without interrupt trigger") changes the
first part.

Thanks,
Andrei

