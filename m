Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C6CCA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED54E10E974;
	Mon, 28 Sep 2026 18:48:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H6fat/WH";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6525C10E974
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 18:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vttx/+cJefBUnKDaquti2H4mk04bVFaJGk7whQO8LWZxGTbKfLE6V7+ViQxIa31s6lqxV78xEfriSdYohIjl7rI9lHc0BXYAdBq2sO8WZQg0VKHlwf2kbsdu6fZaEVgug8LiN2DJO3GgEa75fFZE4B+1N5bGMLzf7ipewBFnlaJanB9zG7qWDbFa3QJ38Orgp6E/c2TMk4VFaoZN2KV8tyi17ampaW8b8LmFANvjX1ogWSUM3i6Aztb0LHcAaY3KQT37lwoMdqTJ7SvBBCMpzMPwDaBFUr7Yc9Ql7wtU0FDJe2EWbKXE5A51KOeCV1D2rLnvQFoxiQIhhI0rsKJu2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AAG+LstuWtWHknTSK3e6OmbbS8s8Le3n0TKW+hA7PE=;
 b=skv+EzYmBIL2I8t5+LaxPEH6KddjCf+1xIpjFi2mr6TDPLmQ9Qeov0Cj25aBFfnLaoWFyGDcH9esaqhujvBLkYpcZZ1VgHO5lzfhd1nXFSFtuPXkCSEm69fx+nU2Um9maxWAmvqggdGWPNY8vfs9T4l0ar6fKt4uWmvmw2W01fejj02u7i8IOTyQnoBeZFV5WtwqLVq3rE5Oggr1DiX1WVbdSbiCe9HHHzSn9wDNw1diwY2m1nYb7LHwdEoMix8TbqZj9z7rzWEs/PqnG39SjVtsqCV0wFtPL17JmlFAqhCpLL+JlWBEGAq4+offKhdU3V9kfIvv7venFTTP7GHPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AAG+LstuWtWHknTSK3e6OmbbS8s8Le3n0TKW+hA7PE=;
 b=H6fat/WHEox2rFjrJg4cu1KsdphsqZSlztqBtsSoLUZoPSrhguYUb21dHoK9S0hXWPgTn25OC7vkdTrob6xJQtYHR2bYudtSA3pppVNhCTUlI+kPeMIZNkl1uTICh9RRhevP9LSWd0tcwWMivJsoRPdIP+b/9PitZcka9Ax4qm4=
Received: from CY5PR22CA0092.namprd22.prod.outlook.com (2603:10b6:930:65::7)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 18:48:52 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:930:65:cafe::a1) by CY5PR22CA0092.outlook.office365.com
 (2603:10b6:930:65::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 18:48:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 18:48:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 13:48:50 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 28 Sep 2026 13:48:49 -0500
Message-ID: <4911a7fd-036c-1319-3ad8-d1ef8dc7f461@amd.com>
Date: Mon, 28 Sep 2026 11:48:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V0 08/21] accel/amdxdna: Restore power mode override on
 AIE4 hardware start
Content-Language: en-US
To: David Zhang <yidong.zhang@amd.com>, <quic_jhugo@quicinc.com>,
 <karol.wachowski@linux.intel.com>, <max.zhen@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <sonal.santan@amd.com>, <mario.limonciello@amd.com>, Nishad Saraf
 <nishad.saraf@amd.com>
References: <yidong.zhang@amd.com>
 <20260926013448.3840921-1-yidong.zhang@amd.com>
 <20260926013448.3840921-9-yidong.zhang@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <20260926013448.3840921-9-yidong.zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4a3a57-bb56-4429-bafe-08df1d9123a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|11063799006|5023799004|6133799003|3023799007|22082099003|18092099006|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: hmK4F7bWFibmzrhzGniBRAGX4fwjrsJWzDDYpd1RplpDk7mnp5s/2WLTdB6KhOw7kYfCAMg9MNfU4Du4r9P8qni+qGME4Xb/XafM9bi6A5ZoxIo3bTZ8nwKQZAhVikFdiyZN76IiXZXm1VN378J5MVR7RfK5wQ1PfOQ+sYz5ykQqyNwH1jy6Gvx4+5rJN9Wq875xf1C+ETNEux1Nfr7RMCOhC3z4I0VmSSDJ+HbqQXkFx6JQyyiuIJrsu15mvYbGAuxLfZ2upoQTjfo4bN0SA9il3I8V8lbWGa2m8Sy5sTkBnEA7stK7IM5EtafuaJvdXummU7quzCuDJzfpfEapCyBOU2tFpAwXcy4LaWkyyCOSBAQ4dZgpeYqKE8uF9hk42jzOxrchLr9/yeqnjzwcM0sR1Ua8dRyxY8aLahniDDYpwJEfSiBMYGqLsGPsRskUocPjY0uQbz2Z/1+z9fHy55Z50oalXOP0OqLHi8ji+WfGrZL9a0xmt2CbQXg9qtWidcueLmJoflEPwypJKsrra8El0bhBlvu2XHn3KQ6rTCS9NlCvTlwDhyDqPEDlBpzPG5eqKhvWH/yPjR/6EwIKwXu/1dk1QTmsl+D60EvEkfu/vqMcMS1CF6yCXS/7nlGOoMJ9IOKjKfFdO57GY/MZm4b+/CG1vmCmv+23FknNqD5u/Zh/2jWCxbMmIOwXaQJxNQ5ZsktFo4rym9MKrdXp8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(11063799006)(5023799004)(6133799003)(3023799007)(22082099003)(18092099006)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IRi9M1tF6eLFWJT4WVJz39OQJhwYIC/hBLKB28hSOGh8goO6DPssMnAIxDJvwe+eII/ihrx67V0bd+SBMxExOo+hpQbXKeH3x8r6G7j2ZoGdZ/7+Vbwk7ucvmkwaQD5s6pGZ9bk2vFt0fMcfguQdwcSaTOzQBPRMcKyDziLRxfffwNc9fHitwl6r6Mi9i/dhPHkyydyjh31u3QdzQo4vjNltEoTZnDKDOu5l3WamXbBsCetN3Crhwq98kIDUHZ6YsoRmiohTfDlVBDEt1OHsDzqKfuekrODODgyOas30EJyNFwp5X5RmoLg0jjswdFKmrIj+8SKOr2q4YBLu0L2HAyp7/UdDfolZwkHkZ1y/WGdNixcWpserjXZkj/Rjs+eWmMsoX/nvSNfVQHW5m/mf2dPCsJiPwzvGtcklIGcBUnzGLIW88vZA/LOmox/jjlAi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 18:48:51.4565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4a3a57-bb56-4429-bafe-08df1d9123a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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


On 9/25/26 18:34, David Zhang wrote:
> Firmware boots in POWER_MODE_DEFAULT after a reload, so re-send the
> cached user power mode override whenever the hardware starts. This
> ensures the driver cache (ndev->pw_mode) and the firmware power state
> remain consistent when the hardware is reinitialized (e.g. across
> suspend/resume and runtime PM cycles).
>
> Add aie4_restore_power_mode() to re-send the cached override once the
> mailbox is initialized in aie4_pf_hw_start(), aie4_vf_hw_start(), and
> aie4_classic_hw_start(). On a fresh probe, pw_mode is POWER_MODE_DEFAULT
> so this is a no-op. Failure is returned to the caller so hardware start
> aborts cleanly, preventing the driver from continuing with a dead
> management channel if a timeout occurs.
>
> In aie4_classic_hw_start(), if aie4_restore_power_mode() fails after
> aie4_partition_init() has already succeeded, tear down the partition
> before releasing the mailbox so the firmware partition created just
> above isn't leaked on this error path. aie4_vf_hw_start() needs no such
> fix: it never calls aie4_partition_init() itself, so partition teardown
> is not its responsibility; the PF reclaims VF partitions.
>
> Note that system and runtime suspend/resume callbacks (.suspend and
> .resume) for AIE4 are implemented in a subsequent patch ("accel/amdxdna:
> Implement AIE4 suspend and resume"), where the resume handlers invoke
> these hw_start functions and trigger this power mode restoration.
>
> Co-developed-by: Nishad Saraf <nishad.saraf@amd.com>
> Signed-off-by: Nishad Saraf <nishad.saraf@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> ---
>   drivers/accel/amdxdna/aie4_message.c |  7 ++++--
>   drivers/accel/amdxdna/aie4_pci.c     | 35 ++++++++++++++++++++++++++++
>   drivers/accel/amdxdna/aie4_pci.h     |  3 +++
>   3 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/accel/amdxdna/aie4_message.c b/drivers/accel/amdxdna/aie4_message.c
> index a7025995d0e0..f5a17e10cc86 100644
> --- a/drivers/accel/amdxdna/aie4_message.c
> +++ b/drivers/accel/amdxdna/aie4_message.c
> @@ -166,7 +166,10 @@ int aie4_msg_set_power_mode(struct amdxdna_dev_hdl *ndev, u8 power_mode)
>   
>   	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
>   	if (ret)
> -		return ret;
> +		XDNA_WARN(ndev->aie.xdna,
> +			  "Failed to set power mode %u, ret %d", (u32)power_mode, ret);
> +	else
> +		XDNA_DBG(ndev->aie.xdna, "Power mode set to %u", (u32)power_mode);
>   
> -	return 0;
> +	return ret;

Should this be part of patch 07/21?

Lizhi

>   }
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index 3a063d3ffa94..f72d0dac8263 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -295,6 +295,27 @@ static int aie4_query(struct amdxdna_dev_hdl *ndev)
>   	return 0;
>   }
>   
> +/*
> + * Firmware always boots in POWER_MODE_DEFAULT after a (re)load, so re-send the
> + * cached user override whenever the hardware starts. This keeps the driver
> + * cache (ndev->pw_mode) and the firmware power state consistent across
> + * suspend/resume and runtime PM cycles. On a fresh probe pw_mode is
> + * POWER_MODE_DEFAULT and this is a no-op.
> + *
> + * Power override is a per-VF property in firmware: each supervisor (VF) stores
> + * its own requested mode and the hypervisor arbitrates globally by taking the
> + * highest mode across all supervisors. A full firmware reload on suspend clears
> + * every supervisor override back to default, so each device type (PF, VF and
> + * classic) must re-send its own cached override on resume.
> + */
> +int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev)
> +{
> +	if (ndev->pw_mode == POWER_MODE_DEFAULT)
> +		return 0;
> +
> +	return aie4_msg_set_power_mode(ndev, ndev->pw_mode);
> +}
> +
>   static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>   {
>   	int ret;
> @@ -311,6 +332,10 @@ static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		goto mbox_fini;
>   
> +	ret = aie4_restore_power_mode(ndev);
> +	if (ret)
> +		goto mbox_fini;
> +
>   	return 0;
>   
>   mbox_fini:
> @@ -348,6 +373,10 @@ static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		goto mailbox_fini;
>   
> +	ret = aie4_restore_power_mode(ndev);
> +	if (ret)
> +		goto mailbox_fini;
> +
>   	return 0;
>   
>   mailbox_fini:
> @@ -389,8 +418,14 @@ static int aie4_classic_hw_start(struct amdxdna_dev_hdl *ndev)
>   	if (ret)
>   		goto mailbox_fini;
>   
> +	ret = aie4_restore_power_mode(ndev);
> +	if (ret)
> +		goto partition_fini;
> +
>   	return 0;
>   
> +partition_fini:
> +	aie4_partition_fini(ndev);
>   mailbox_fini:
>   	aie4_mailbox_fini(ndev);
>   stop_fw:
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index 98b637279257..fd2c50dc8080 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -87,6 +87,9 @@ int aie4_hwctx_init(struct amdxdna_hwctx *hwctx);
>   void aie4_hwctx_fini(struct amdxdna_hwctx *hwctx);
>   int aie4_cmd_wait(struct amdxdna_hwctx *hwctx, u64 seq, u32 timeout);
>   
> +/* aie4_pci.c */
> +int aie4_restore_power_mode(struct amdxdna_dev_hdl *ndev);
> +
>   /* aie4_sriov.c */
>   #if IS_ENABLED(CONFIG_PCI_IOV)
>   int aie4_sriov_configure(struct amdxdna_dev *xdna, int num_vfs);
