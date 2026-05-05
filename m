Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673DAFF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 19:53:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 945EB10E0D1;
	Tue,  5 May 2026 19:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tmSeJ1iV";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011013.outbound.protection.outlook.com
 [40.93.194.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B520210E0D1
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 19:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seltnvU7GiEJAXuiVdV6bE5Fx9a1+uG/zNwIh9OThp/lJOGoV2AqkXJ7V2+eypKsBE5nKVEBscPL6eN03HvGX5//KPAXvHBWA6D5ODnJuSx35JonI093vBnSYA6YdXe78Lnfh3/qMbcRb7UuQjJoIs8Di4UkLEssSvHlxqjOoD/SraUTMFTOYeXrY1Pu6PBED0sTkAMZb4+p3z0yDyy64b1/2F905THj+VFQwAtdEQqOaNEqkpeb3itk3yNqsDb5zdYaYqtvhRl568ITxkj7vbP7C1T/Jq0CboY+aGWofmwvEyKLvAnmbfTuB4DwwxRj1WU3qoHaL/qGjd3Zv6WN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSze+TT/M7Eti9bjnXUqCx8K5JmsuHL639Q7C7UR7Fg=;
 b=A/nt29DvhTQDBxGOhAb5i7aCykomj3/L/Idw7FoJcCPMUbZLmk36Xk1QpPJP9akFj2a9PuLn2KcdJD4ZthNydGKBnbYInO/mvsjItYVfzStpI43y7DEChICIy19uYNlkoFRkhrQxuMPIIX7lmM/vjmIQbAj6FGlR/6/RmuA/nSAIzRpPD2axKg3tuw50EPNVpSY4L+d8dnzm8QfsgXdUkwMUrxqcXx/hVjEixg9UTRX6zZmtr6ZUALnDnCXr7IrkRpFSOdmJvlCgVS8O9wuTODNRqjDS5WliJCuZyWFy97WSkg89+tOiW6puYAKKnxad7cWlJKNueKFXrWmbBrrHsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSze+TT/M7Eti9bjnXUqCx8K5JmsuHL639Q7C7UR7Fg=;
 b=tmSeJ1iVmynlSHtL9hUCzfQ4/z8d2a8vz9EoN9qMXHJ8sqEMHCuvGa+HgocWHc+LWXQeBNHFL4F1ivrJxJzW8LIJjkdRSu8KobXfDoYTzk/MCSS66/IwyBQyd2O6d5tf95qIatutxD4ASDXfWafNILJGZM8o77HygBipe3prXvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 5 May
 2026 19:53:37 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 19:53:36 +0000
Message-ID: <0941b2ef-adab-49ed-a9ab-9be0ac188c52@amd.com>
Date: Tue, 5 May 2026 14:53:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/6] accel/amdxdna: Init AIE4 device partition
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
 max.zhen@amd.com, sonal.santan@amd.com,
 Hayden Laccabue <Hayden.Laccabue@amd.com>
References: <20260505160936.3917732-1-lizhi.hou@amd.com>
 <20260505160936.3917732-3-lizhi.hou@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260505160936.3917732-3-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::14) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DM6PR12MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c41407-b24d-4578-f0b7-08deaadffe9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: vJEJS9a0s57f/Sdl3xd+FZHG+zCHFbHTh/I339R51d1xlnnmIrf2SdEuBs2ycsZ5ED7Un6b2uSTAinWgloK8pR2QHqqBIGY8PA97KNuI9cwuQyToYSXlTzz/QlX/rsW2+7X7lj3xF/pCyy3utUJhwBO6wcbZtvxv62+Xp15bNYxmULGonldfeHXkU0A6YPEyW9A2tHO5En1iRFxDMOZEjWL+Gd6c7n00JLTrJVF0eYoYM8BrFIDNSU3yaqsKLI782JNbmucPC3oWTtewagvFjKBVa6bWOMEGB+nvwUwkTUBgzhlQ8XT07UVAhUJBxXTYKOqcYISI9xgcSGATAkGjQxqHmtH/VPNbP9JYMX/Y/VxbV+IB+8s0TDR+CU/ObZ9aZqzCjW+/+0S9XB5dXMAK9mZQ/5PVrWQqtbsuEWvyxC7xU+k3oH1FCL4j1rVMt15GemLe6whKoOW7iNhWFh5/YGQpPWX/s+Dt+EIAIXg8q4lLjOavqAYf4EQ2XOA16dwohBKFgBwX7CDSuGE01UVssUZ/WfQuUtph5ehj7z6gkXfdTMh2JhcLPSpZjJ9QV8GXup9X4vfm4A62tYTcCzvEWftRhzm9xDlDgj5tG178VHnuxhLAOByrGjwCHy/7uoNzpQy9p9tr85XKOGBqlwPxvuxiNMkkI0eNno5nZx7RWTKV5f/ibj8p+gyDRbU2n6M4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW40aGxLZWdrTkNXMG1VZncycGVlb3UyVjhRREZpQzRZQUlwQmFyaWZMQmRa?=
 =?utf-8?B?WkR1Y1E2V2RVbDBJZWtTdURoZmdHMlo1WkJNdStMNjZYRnlrRDBmci9MTkRO?=
 =?utf-8?B?VVB1SVpJc1ZaUXNuVjVLRHhjSGlJd2RXZWdWeUhQKzlUaEVBVTVKWVVjbmth?=
 =?utf-8?B?YWVxeVpaUnN6MElzYkFTR2IyK096YzZESU96aWpTc2RwQTdvRWs3TGFSV1Q3?=
 =?utf-8?B?c01UamRGbEJ0Ni9NMTFkU3M1MWZkL0tSM3RiTTQ2ZFB1ZGUxQjB6R0N3K3Nl?=
 =?utf-8?B?RUVjcWl3bTI2NktKM2Fsc05tUmVUZFRRd1FVY0EyR0U3SjE0TEpDMFV4VlB3?=
 =?utf-8?B?UEtsRm1IUFJzT1Y4QjQrNzEvclg4cEhVSFZJckphaGo5ckt1OVkxa1UvMC92?=
 =?utf-8?B?QTh0WktKeEpUWklGSHFsanhuVW16eGQ1dWZ4THAydy96R2NXbkFMVUlpR3A3?=
 =?utf-8?B?SUs5bUtrZmpvNHcwVnhodUNSc2pqeXgvM3piTVdHckNvMXhWaXlmT0g2TTdO?=
 =?utf-8?B?RmtHVmd5OHd3dkdtMHdjQzF1VkZDTVNxMmxnNnlONEJEV1IwaG96MzdkMEww?=
 =?utf-8?B?UDJNNjZ0MnNVWGZwUEFEeXJURnNZNlhHWHQ5RFFrWXRnbk1BakNiRWJFMXZo?=
 =?utf-8?B?b1dhbjR5Yi9jYU13Mi9SbXl4ckYrMlVUbEUrSHhjcFBjcHpPWnhCS2dPc1B5?=
 =?utf-8?B?R1VSZVkrZTdSekRWSEg4Y2FsRU1JU3c0eS9yVkpnTVFPSW5jZnVuR1EwQmhv?=
 =?utf-8?B?QlFGQnZjQnZYSTNpbkQzaDBtR24xQWVaL2RMdi9wN0dtWVJYODA2bHlvVmd2?=
 =?utf-8?B?OEFaSng1TzdYUkNSTlZla3o0ZTRjTUJxak5rYkQvN2VJRGVFL1didVpDMFNX?=
 =?utf-8?B?cHJJTFJxaHgySDlFTVNybXhEenRVRUNramxReVF5WmhhR3NrUVhIUDlMSG05?=
 =?utf-8?B?RjV4QVJUU2I3UUcwVnYzRnVhTWRwSys2RDd3YVRjdjFYdXg2NUxKQlB6Nkg1?=
 =?utf-8?B?aFZ3UEk2NEZReGFkckxBNkF6b3pBa2xhL3NCRjkyaDBEc0NqdVZFY1ZrQzBX?=
 =?utf-8?B?VFNUUERaMzRUMXNFQTIwSkZ6T0ZxanZhelJZZ0ZjZWgvSEF5NDQvZFQzNFhy?=
 =?utf-8?B?UEVSVE1yeGo3VlVDdCszZGdXUDBoR2djRnpwbzlNeDFTN3JjNUN1bW1xNTdZ?=
 =?utf-8?B?azgwUTZkazZ4RmwrYTZoQXBDcDhnbU9vU3FwWWFnOUtVWFJCM2ZsbEpMOXlB?=
 =?utf-8?B?cDVRN3lWdDI2KzQyeU9JRXZlQWRILzJwdmlURmoxeVhQaHlRb21QT2E2cmJD?=
 =?utf-8?B?c3VFRFFHRm5wa3psMVd0OWRhd3FIUkJWMmova2pJVUNteWl5eXdYaVIwQXZj?=
 =?utf-8?B?bWhwVVV1VFQxREtpUytwUlZlMFV0S3VpMGpyVjdJZDlNTjZEWWNoVXlCYTZH?=
 =?utf-8?B?WVhEQ2NobUFQd0thRFpWb1JQencwR3h4c0xtOTBkSFdrMHg3eFhEVzhoU21E?=
 =?utf-8?B?RmQrcFhkRlYrUGE0NUVMaUpvbHQ5UU50WEVnemZZZHRNOC9pb1gzRTJuVFA5?=
 =?utf-8?B?em9NTVZ0SzRMd2ltVzJaTk5PMWxNemoxdTMvdWRjeUoyVkp0V0FvUDZySTcx?=
 =?utf-8?B?UTBwVFh6eHFRN3FPMUY0QWRSS29QbnRiREs0cVM2QzVweDh0cVQ0YS9TYlNF?=
 =?utf-8?B?L3Blc0dQdjk5NmV6Qm1yV3FQUDRiSHRNQTZTdlQvUUtjU0xNMm5HNk9UYWdL?=
 =?utf-8?B?MmRLZHFCelhEMWIxdER2YzQyY1NwUXpSMFczQmZUcXZxb00xNVlNYWR6amtq?=
 =?utf-8?B?SndiR041K1kvd0QvclA0ajdkYlljRjdhTlBycWkxd203WjVnbEp5Q0NkSnJD?=
 =?utf-8?B?MnpsQU9XMFdKUy80K0lTWS9hZFlQMXVVbWRaVVJCZjRSTWV5R25YQUVDMGZ6?=
 =?utf-8?B?djRwSG96Y0hxWjZDaStjdHZZcS9xVklBK2tCRGtyQjFEOWp3T3JhSVRlSTZo?=
 =?utf-8?B?TnZORGd0Vkd3aFdTdFpLT2ZERm5SaW9CYnZ0OUtXWmpwT0did1BGNmQxcjJQ?=
 =?utf-8?B?STh6aVJudzZBZTF0L3BneWkrOW5YeDhlK0ZrODdVZ3FYbHFXaldSWmRpUTFX?=
 =?utf-8?B?RVNPYnVpR3NkU1loYWxsbHhDSldZaXBHZlVXZkN5SzRTeVZCSGZVdGxLTlp0?=
 =?utf-8?B?VUhhN2krYStzOEJxbDdxa1JIRlhxUm1JczJYSkZnTDI0VUlpT3F3cnF4eDVs?=
 =?utf-8?B?cWxVUnBHRlYzR0c3NDJscVBMRjdDMmtOejNHL3hCVkJFT1NqZFl2SHdGK1Ny?=
 =?utf-8?B?ZGx2ei85Q0pLUmIySmhBMTVkeGIydEVDaGJJRENtbzhxYkx3WkcxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c41407-b24d-4578-f0b7-08deaadffe9d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 19:53:36.1071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHiJzRrM7ynHPeHL/SunmNRYcR+rnKP7tc8x0IJyO6BF5Yz35AHZjXgLdBBIDbxyoSxSQ08jSuPEfj6qc49ZWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
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



On 5/5/26 11:09, Lizhi Hou wrote:
> From: David Zhang <yidong.zhang@amd.com>
> 
> Send partition creation command to firmware during VF initialization.
> 
> Co-developed-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: Hayden Laccabue <Hayden.Laccabue@amd.com>
> Signed-off-by: David Zhang <yidong.zhang@amd.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>   drivers/accel/amdxdna/aie4_msg_priv.h | 21 +++++++++++
>   drivers/accel/amdxdna/aie4_pci.c      | 52 ++++++++++++++++++++++++++-
>   drivers/accel/amdxdna/aie4_pci.h      |  1 +
>   3 files changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/accel/amdxdna/aie4_msg_priv.h b/drivers/accel/amdxdna/aie4_msg_priv.h
> index 88463cc3a98a..cada53257921 100644
> --- a/drivers/accel/amdxdna/aie4_msg_priv.h
> +++ b/drivers/accel/amdxdna/aie4_msg_priv.h
> @@ -13,6 +13,9 @@ enum aie4_msg_opcode {
>   
>   	AIE4_MSG_OP_CREATE_VFS                       = 0x20001,
>   	AIE4_MSG_OP_DESTROY_VFS                      = 0x20002,
> +
> +	AIE4_MSG_OP_CREATE_PARTITION                 = 0x30001,
> +	AIE4_MSG_OP_DESTROY_PARTITION                = 0x30002,
>   };
>   
>   enum aie4_msg_status {
> @@ -46,4 +49,22 @@ struct aie4_msg_destroy_vfs_resp {
>   	enum aie4_msg_status status;
>   } __packed;
>   
> +struct aie4_msg_create_partition_req {
> +	__u32 partition_col_start;
> +	__u32 partition_col_count;
> +} __packed;
> +
> +struct aie4_msg_create_partition_resp {
> +	enum aie4_msg_status status;
> +	__u32 partition_id;
> +} __packed;
> +
> +struct aie4_msg_destroy_partition_req {
> +	__u32 partition_id;
> +} __packed;
> +
> +struct aie4_msg_destroy_partition_resp {
> +	enum aie4_msg_status status;
> +} __packed;
> +
>   #endif /* _AIE4_MSG_PRIV_H_ */
> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie4_pci.c
> index a967e2db7ebd..13f5d45e388d 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -9,11 +9,16 @@
>   #include <linux/firmware.h>
>   #include <linux/sizes.h>
>   
> +#include "aie.h"
> +#include "aie4_msg_priv.h"
>   #include "aie4_pci.h"
> +#include "amdxdna_mailbox.h"
> +#include "amdxdna_mailbox_helper.h"
>   #include "amdxdna_pci_drv.h"
>   
>   #define NO_IOHUB		0
>   #define PSP_NOTIFY_INTR		0xD007BE11
> +#define AIE4_TOTAL_COLUMN	3
>   
>   /*
>    * The management mailbox channel is allocated by firmware.
> @@ -234,6 +239,36 @@ static int aie4_fw_start(struct amdxdna_dev_hdl *ndev)
>   	return ret;
>   }
>   
> +static int aie4_partition_init(struct amdxdna_dev_hdl *ndev)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_create_partition, AIE4_MSG_OP_CREATE_PARTITION);
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	int ret;
> +
> +	req.partition_col_start = 0;
> +	req.partition_col_count = AIE4_TOTAL_COLUMN;
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret) {
> +		XDNA_ERR(xdna, "partition init failed: %d", ret);
> +		return ret;
> +	}
> +
> +	ndev->partition_id = resp.partition_id;
> +	return 0;
> +}
> +
> +static void aie4_partition_fini(struct amdxdna_dev_hdl *ndev)
> +{
> +	DECLARE_AIE_MSG(aie4_msg_destroy_partition, AIE4_MSG_OP_DESTROY_PARTITION);
> +	struct amdxdna_dev *xdna = ndev->aie.xdna;
> +	int ret;
> +
> +	req.partition_id = ndev->partition_id;
> +	ret = aie_send_mgmt_msg_wait(&ndev->aie, &msg);
> +	if (ret)
> +		XDNA_ERR(xdna, "partition fini failed: %d", ret);
> +}
> +
>   static int aie4_pf_hw_start(struct amdxdna_dev_hdl *ndev)
>   {
>   	int ret;
> @@ -267,7 +302,21 @@ static void aie4_pf_hw_stop(struct amdxdna_dev_hdl *ndev)
>   
>   static int aie4_vf_hw_start(struct amdxdna_dev_hdl *ndev)
>   {
> -	return aie4_mailbox_init(ndev);
> +	int ret;
> +
> +	ret = aie4_mailbox_init(ndev);
> +	if (ret)
> +		return ret;
> +
> +	ret = aie4_partition_init(ndev);
> +	if (ret)
> +		goto mailbox_fini;
> +
> +	return 0;
> +
> +mailbox_fini:
> +	aie4_mailbox_fini(ndev);
> +	return ret;
>   }
>   
>   static void aie4_vf_hw_stop(struct amdxdna_dev_hdl *ndev)
> @@ -276,6 +325,7 @@ static void aie4_vf_hw_stop(struct amdxdna_dev_hdl *ndev)
>   
>   	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
>   
> +	aie4_partition_fini(ndev);
>   	aie4_mailbox_fini(ndev);
>   }
>   
> diff --git a/drivers/accel/amdxdna/aie4_pci.h b/drivers/accel/amdxdna/aie4_pci.h
> index cbf3424a4341..620fb5bd23e4 100644
> --- a/drivers/accel/amdxdna/aie4_pci.h
> +++ b/drivers/accel/amdxdna/aie4_pci.h
> @@ -31,6 +31,7 @@ struct amdxdna_dev_hdl {
>   	void			__iomem *rbuf_base;
>   
>   	struct mailbox			*mbox;
> +	u32				partition_id;
>   };
>   
>   /* aie4_message.c */

