Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E90CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1142410E63C;
	Fri,  2 Oct 2026 16:34:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TIbDqmmw";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010067.outbound.protection.outlook.com
 [52.101.193.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A6810E63C
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 16:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1iY68TrPo+OtlF2NoDnFCZV98VsubSv5iSTvJA8MNKykCyb7IADeEq7dJenCK7+CniyvJBfxyVTNGo1mVkxJCmeFrJKuguXb3ybn4LoOH7ySr6e643IM7W2psiz/btAi/tjF18PCL/ZQT7TLpbSfWnaM/TWk54GdYdu2RJ8fOKX6t97vN9BZ2XbtxIqW9O8FSHo081QmJKt1GjSmtI3yWNgOYstlsAe20KRtDdhpuhqqRBLnAhT1Rk/91RMuoVPVySucQoqo/UW/dy588xBf6TPGogCh4ethiGltwqHbpTBgFSjthmKHB3IzU9clIu5PnPFWK6ff0xKDu10SWo/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgArAOuJAtpjP2rkkOJFlU//Huq70hO8baEe5hrAMXE=;
 b=jWFF6AZ6LBj2sMmQ1mS6uYrbUBJOdG4fetDR9uNQ6o56W/hPbI6ho5RVtsYXw0LFcKmK7ba8ICUqWURe8Jb1UezQkdxFj7jBrJ3X800v+1oUBmicuV5esEcsDPrKf8KsmKTsfykyEVv/3QAsYjVqYWleEohhJ1A8xJ4Dk0Rf6kTlXbTDWBT9uygjl1TKYgbYIEQ6adSib5KrhvfUiGvCk/hXgUboHT9orsxiSMzgHInHxNy6h/7Z9i4fST+64B34Hk+D7lmV6AkDZ8Z6DTLIDJtfkH/RuXsYE7x2bmZVe53HGvV88S3jiAzinL5yf96qqQeu4ZaVoOP1Fuf2K24Ckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgArAOuJAtpjP2rkkOJFlU//Huq70hO8baEe5hrAMXE=;
 b=TIbDqmmwW9W89aX/ljB3R6NLd9xUeAUNQGt9YF4BeSZFKXIgk7tdxEooufzE8WbNlG80hi3W0IESdraNfY4aSSEkvRPswHkItPYlDH/6QZbS3zRHitvNL/1/eXO7ClU0bcpu5WHB91o2kin28z8mvuRYM+vobTKGzckXgNSND1Y=
Received: from PH7PR10CA0007.namprd10.prod.outlook.com (2603:10b6:510:23d::7)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 16:34:26 +0000
Received: from CY8PEPF0000005E.namprd21.prod.outlook.com
 (2603:10b6:510:23d:cafe::21) by PH7PR10CA0007.outlook.office365.com
 (2603:10b6:510:23d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 16:34:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF0000005E.mail.protection.outlook.com (10.167.247.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 16:34:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 11:34:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 11:34:25 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 11:34:24 -0500
Message-ID: <67698952-6394-44a8-01fe-3e3558b7cb4c@amd.com>
Date: Fri, 2 Oct 2026 09:34:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: bound the firmware-supplied mailbox ring
 against the mapped region
Content-Language: en-US
To: Eva Crystal <0xiviel@gmail.com>, Min Ma <mamin506@gmail.com>, Oded Gabbay
 <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <sashiko-reviews@lists.linux.dev>, Sashiko AI review <sashiko-bot@kernel.org>
References: <20261002063739.184503-1-0xiviel@gmail.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20261002063739.184503-1-0xiviel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005E:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d50d53-4b4a-423b-8223-08df20a305d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|10067099003|5023799004|56012099006|3023799007|11063799006|22082099003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: 2SU2krKiMQZJC8iIALfU5Dvpbefioe5ZpdYMUUtao1cwFRX6c7r5H7Xt7IKgXOH2EEJae7xPsmSLUCMwWoAL9SyWiO5QygsZQd2YO7zaizaG5pjsW1FtMc178XOdgigJCgKKO0EJi7kIa/luCzDIxJHg9P3f8ouM0f/RP2W6jniVYQh3AOG2/0FRf391WzYMp0bfZUkdmCgrJHjDUTNN7okrQRzeBlxXIFh8xpRsF6+1DRdogbya6jkJTEf/+MTW1P/Wey1//8J0IZk2FLzww4NkT+Hpz3nusVQ0ls2ohGMd8ZZrRGgRZIGzDi6URHLgJyxeGUohAqJbJlesRonVbV8eqAzkdNjVyk9rLfw16gRqJzc5t/SW8ji2MK8j4K2D9aKou3HrD3PrdgWkLoBP8NpyZasU860n2/RjYzSZYWj48za5Wk4ARznI/3HgU/CHmjXSEtI3Z16fnXPyfHO4y/R850FVrh1/qIMO6J3uMwcACB7K0TP3HfT0bD9jzbvV6rB3u5CJxlxTHZtnRPYuij+mDYMSd6Hk3yvmyIBKKlvksVrOjKBI+6OiGi0wOAjcc0oyCksgnxXR5WCX+tKB+kieo8sYwjnBOXLAkKN14Ko=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(10067099003)(5023799004)(56012099006)(3023799007)(11063799006)(22082099003)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RmNZKvUarFbdM9r9TINi+Mz62EwnRsP9k66zk+nd9a4yMoA50219uHygv2/nn0IbvKbQ7iy4wXCKoImV1El1c49KlIRWh9DRgvX/xjTcrGHrTJw16otJJYt8uoVC4/+HMfYIw587PY6pfMS6+jLf2clfg04Q8RqLR5S4dyCb9Zxw8UJPL2PEaHs7llLzd0HuHQEToNEZNXsJ1ykByx2RuCMbK5f2UI0UPNRJBcxAJU1iZFBzPsF4eRMcF/HfciTC4urjj9P8sl1pIoqrkhCgDB5MqX/RqhO7YnH4Sz4aNSpZQRcgye2sP5tq5eCs3/wuM+XyMLS4rFuBSRTcDFjLexdpYPCH6ieE5GQTzyFM4PeR62YHSSE7uJlw+jdGvVtwOfhdIYRXYzM0aUwQ5+IJwHgTCptezmtrn9+bmqiU7tOkSD5JK3uyHAR0+RK9WDGs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 16:34:25.8906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d50d53-4b4a-423b-8223-08df20a305d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF0000005E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362
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


On 10/1/26 23:37, Eva Crystal wrote:
> The mailbox ring start address and size both come from firmware, and
> rb_start_addr is used directly as an offset into the ioremapped SRAM BAR:
>
> 	read_addr = mb_chann->mb->res.ringbuf_base + start_addr + head;
> 	header.total_size = readl(read_addr);
>
> Nothing compares it against the length of that mapping. The only gate
> between the firmware words and that readl() is is_power_of_2(rb_size) in
> xdna_mailbox_start_channel(); the bounds tests in mailbox_get_msg() are
> all relative to the firmware-supplied rb_size, not to the mapping. The
> driver does record the true length, in struct
> xdna_mailbox_res::ringbuf_size from pci_resource_len(), but that field is
> never read anywhere.
>
> So firmware can describe a ring that starts past the end of the BAR, and
> the receive path reads there. Measured on an npu4 device (0000:06:00.1,
> 1022:17f0 rev 0x10, fw 1.1.2.64) by moving i2x_buf one page beyond the
> window: the channel starts, the first firmware response drives
> mailbox_get_msg(), and the peek readl() in mailbox_rx_worker faults on a
> not-present page at exactly ringbuf_base + ringbuf_size. pcim_iomap()
> maps the whole BAR, so one byte past the window is already past the
> mapping. This happens during probe, before any device node exists, so no
> userspace is involved. The oops kills the mailbox worker mid work item
> and probe then wedges in drain_workqueue(). Only the read direction was
> measured; nothing is claimed here about the write path.
>
> Reject a channel whose ring does not lie entirely inside the mapping.
> The check sits in xdna_mailbox_start_channel(), which is where all three
> producers of this geometry converge: the management information block in
> aie2_get_mgmt_chann_info(), the CREATE_CONTEXT response in
> aie2_create_context(), and the mailbox information block in
> aie4_mailbox_start().
>
> Reaching this needs firmware that reports geometry it should not.

Thanks for providing the patch. The firmware is signed by AMD and driver 
can trust the register reading and management channel responses.

Adding more and more checks to verify the trusted firmware responses 
does not seem to be helpful. Instead, I would suggest to add comment for 
this which helps sashiko to better understand the design.

There are few legacy checks for rb_size which was used for firmware 
debugging and those should be removed.

Lizhi

> npu*.sbin is signed and loaded from root-owned /lib/firmware, so this is
> not something an unprivileged user can drive. The file already validates
> other firmware input on this path, the MGMT_MBOX_MAGIC check,
> aie2_check_protocol() and the tail pointer in mailbox_get_msg(), so the
> standard applied here is the one it already sets for itself.
>
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260913214451.639251F000FF@smtp.kernel.org/
> Signed-off-by: Eva Crystal <0xiviel@gmail.com>
> ---
>
> This was first raised publicly by the Sashiko AI review bot on dri-devel on
> 13 September 2026, in its automated review of my own mailbox register-offset
> series, where I then listed it as deferred in the v2 cover letter; this patch
> is the measured follow-up to that report.
>
> To be precise about scope, because that report raises two items and this patch
> addresses only the first: it bounds the ring's placement and span against the
> mapping. It does not bound rb_size from below, so it does NOT fix the second
> item in the same report, where a tiny but still power-of-two rb_size (e.g. 2)
> makes mailbox_get_ringbuf_size() - sizeof(u32) underflow and widens the
> send-path wrap bound. I checked that case against this patch and the patch
> accepts it: is_power_of_2(2) passes, and all four of the added clauses read
> false on an honest rb_start_addr. That item is not mine to claim, it was
> published in the same message, and if it is addressed it should be a separate
> patch crediting the same report. I have not measured it; the underflow is on
> the x2i/send side and the harness described below has no x2i override.
>
> The mailbox ring start address and size are both supplied by firmware, and
> rb_start_addr is used directly as an offset into the ioremapped SRAM BAR
> without being compared against the length of that mapping. The only gate
> between the firmware words and the first readl() on the receive path is
> is_power_of_2(rb_size) in xdna_mailbox_start_channel(); the three bounds
> tests inside mailbox_get_msg() are all relative to the firmware-supplied
> rb_size rather than to the mapped region, and struct
> xdna_mailbox_res::ringbuf_size, which the driver fills from
> pci_resource_len() and which holds the true window length, is never read
> anywhere in the driver. A firmware-supplied i2x_buf that places the receive
> ring base past the end of the window therefore produces an out-of-window
> read. This patch adds the missing comparison in
> xdna_mailbox_start_channel(), which is the single point all three producers
> of this geometry pass through (the aie2 management block, the aie2
> CREATE_CONTEXT response, and the aie4 mailbox info block), and fails channel
> start when the ring does not lie entirely inside the mapping.
>
> How this was measured. On an npu4 device (0000:06:00.1, 1022:17f0 rev 0x10,
> firmware amdnpu/17f0_10/npu_7.sbin, fw_version 1.1.2.64, HP OMEN 16-ap0xxx,
> kernel 7.1.5) I built the driver out of tree with instrumentation that logs
> the ring geometry and recomputes, for every ring access, whether the target
> lies inside res.ringbuf_base + res.ringbuf_size. A module parameter
> overrides exactly one firmware field, info_regs.i2x_buf, at the point it
> lands in aie2_get_mgmt_chann_info(), i.e. upstream of every gate, so the
> whole downstream path is the driver's real one. The override moved the
> receive ring base to BAR2 offset 0x80000, one byte past a 0x80000 window.
> The channel started with no complaint, the only check applied being
> is_power_of_2(rb_size)=1, and the first response from firmware then drove
> mailbox_get_msg(). The peek readl() faulted:
>
>    BUG: unable to handle page fault for address: ffffd0db86b80000
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    Workqueue: xdna_mailbox mailbox_rx_worker [amdxdna]
>    RIP: 0010:mailbox_rx_worker.cold+0xb6/0x43b [amdxdna]
>
> The faulting address is exactly res.ringbuf_base + res.ringbuf_size in both
> runs; pcim_iomap(pdev, 2, 0) maps the whole BAR, so one byte past the window
> is already past the mapping and the PTE is zero. This happens during probe,
> before /dev/accel/accel0 is created, so no userspace component is involved.
> As a secondary effect the oops kills the mailbox worker mid work item, and
> the RX timeout path then calls drain_workqueue() on a work item whose worker
> is dead, so probe wedges in uninterruptible sleep and the module cannot be
> unloaded.
>
> The same override was run twice, from two independent boots, the second with
> preconditions recorded beforehand (tainted 0, in-tree module, device bound).
> Everything that identifies the defect was identical across the two runs: the
> access type, the not-present PTE, the workqueue, the RIP symbol and offset,
> the faulting instruction bytes, every frame and offset of the call trace, and
> fault minus base equal to res.ringbuf_size. The only differences are the
> ioremap base and the module load base, which a reboot is expected to move.
> A benign control, the unmodified firmware geometry, was run through the same
> instrumented build across two runs, with both the straight-line and the wrap
> branch of the send path exercised, and all 513 bounded ring accesses landed
> inside the window.
>
> What I am not claiming. Both injection arms overrode the i2x (device to
> host) direction only and left x2i untouched, so the send path ran on honest
> geometry throughout. There is no measurement here of what an out-of-window
> x2i->rb_start_addr would do at the memcpy_toio() in mailbox_send_msg(); no
> write-path injection was attempted, and nothing in this report should be read
> as a write-side or code-execution claim. What was measured is a 4-byte
> out-of-window read that faults on a not-present page, and the probe wedge
> that follows. The per-hwctx path is also uncovered: the second producer of
> these same values is the CREATE_CONTEXT response in aie2_message.c, and
> exercising it needs a userspace stack to create a hardware context, which
> was not available on this box, so only the management channel was driven.
> The instrumentation for the cq_pair path exists and never fired. The same
> absence of a window check applies there on paper, and the fix sits in the
> common function, but that path was not measured. Separately, a second arm
> that overrode rb_size instead of rb_start_addr was accepted by the driver
> and recorded as exceeding the window, yet produced no out-of-bounds access
> in 137 accesses, so rb_size alone is not sufficient to leave the mapping;
> rb_start_addr is.
>
> The patched driver was then run on the same device, six arms across six clean
> boots, each arm a single override of the same instrumented build (one module,
> one sha256, no rebuild between arms). Honest geometry is accepted and the
> device works normally: probe completes, /dev/accel/accel0 appears, 10 workload
> passes return 100/100 queries, and 32 real ring accesses all land in window.
> Four out-of-bounds geometries are rejected at channel start, before any ring
> access, with no page fault, no oops, and a clean module unload in about two
> seconds: rb_start_addr equal to the window length, rb_start_addr strictly
> greater than it, an oversized span, and a non-power-of-two rb_size handled by
> the gate already shipped. The rejection cascade is byte-identical across those
> arms except for which gate names itself.
>
> What that does and does not establish, clause by clause. The two receive-side
> clauses are each exercised in isolation: the span clause by an oversized
> rb_size on an honest rb_start_addr, and the placement clause by
> rb_start_addr=0x100000 against a measured ringbuf_size=0x80000, where the span
> clause cannot fire at all because ringbuf_size - rb_start_addr underflows in
> size_t to 0xFFFFFFFFFFF80000. That is the arm which shows the two clauses are
> not redundant. Two limits on it, stated rather than left to be inferred: the
> kernel short-circuits at the placement clause and so never evaluates the span
> clause on that input, which means the span clause's falsity there is
> arithmetic over hardware-measured operands rather than an observed branch, and
> I did not build a variant with the clause removed to show acceptance directly;
> and that arm has had one hardware run, not two, so I am not describing it as
> reproduced. The two x2i clauses were never injected at all and remain
> unexercised, for the reason given above.
>
> Finally, the injected values stand in for firmware rather than coming from
> it. The module parameter writes the word where the firmware word lands, so
> the path below that point is real, but the firmware itself was never made to
> publish these values. npu*.sbin is signed and loaded from root-owned
> /lib/firmware, so this is not reachable by an unprivileged user on a healthy
> system; I am proposing it as the same kind of defensive check the file
> already applies to other firmware input on this path (the MGMT_MBOX_MAGIC
> check, aie2_check_protocol(), and the tail pointer in mailbox_get_msg()).
>
> The full oops from both runs, the instrumented build, the runners, the
> control run and the complete measurement record are available on request
> rather than pasted here.
>
> Eva Crystal (0xiviel)
> XSource Security
> https://xsourcesec.com
>
>   drivers/accel/amdxdna/amdxdna_mailbox.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
> index 05c3786de135..896b7503cf8d 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -518,6 +518,19 @@ xdna_mailbox_start_channel(struct mailbox_channel *mb_chann,
>   		return -EINVAL;
>   	}
>   
> +	/*
> +	 * The ring start address and size are supplied by firmware and are
> +	 * used as an offset into the mapped ring buffer region. Check that
> +	 * the ring described lies entirely inside it.
> +	 */
> +	if (x2i->rb_start_addr >= mb_chann->mb->res.ringbuf_size ||
> +	    x2i->rb_size > mb_chann->mb->res.ringbuf_size - x2i->rb_start_addr ||
> +	    i2x->rb_start_addr >= mb_chann->mb->res.ringbuf_size ||
> +	    i2x->rb_size > mb_chann->mb->res.ringbuf_size - i2x->rb_start_addr) {
> +		pr_err("Ring buf does not fit in the mapped region\n");
> +		return -EINVAL;
> +	}
> +
>   	mb_chann->msix_irq = mb_irq;
>   	mb_chann->iohub_int_addr = iohub_int_addr;
>   	memcpy(&mb_chann->res[CHAN_RES_X2I], x2i, sizeof(*x2i));
