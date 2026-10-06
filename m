Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF54CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:18:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCFA510E25B;
	Tue,  6 Oct 2026 12:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AAjJKaW7";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013011.outbound.protection.outlook.com
 [40.107.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59C510E11D
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 12:18:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohZav1b9kG2PBP9jQK5mVCTaE0wsMkmIDFp/yjl2mJLtWeFX2BUVS+f3fssB/uSqt6t6IbgXt/MAxMJuzhi27OPPrSY8Pan+FcxiPnoDJWgb3v7oTZDX+CwHga3SMisIrneIRNhx72KgqtBeWjtinlNoVDYjNPGMap9wOriIe0v7yMZSIvByjgDA9D0H543qrESXmhnhX4V9v8CMBa6xH+mPOof9bNOSZF6v1FGTePnaH5f24TWUaUCtpymHnwF9svvJkqr+veYGLJ2JXeLAQrLLHLHbfItKujTjDMVav7F4FegafOyp6yUClrsY9OJlwqTrF/hWv0AHH6MOyGZ2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=793FvEGRMl6kH9bE4DPbzNbJPvC4hZWY6t2hmcXdals=;
 b=IEcqRNLEIzmgIIq8rvPjhlinUDd0+aVnvuEUm64MbEhIN7OUeQEwqKOXkDSMG7oMj9cpoXSZsxJLV7tocEOwAs1rlGQi7VmLx501LqNCZXkYVvBdC3tTqllgjCgDTxgFKWP2c9YqumlKoifcAHKGjJYCE193xt/IkYGOjPluNOprnsrLdtm+n+a8fB+pu4YRtURWmPdMe0tXa1WUZb+l6xbNLiqVYNC9r2iXPXN9MInPHoHVdVxn4GpmpCegESgOCEEGf5eciFIAVMPYTu5jJUjCUVrOyDbgQt23QXxkQvq52VBQvlPPfyXgOkY+cAKJ3BXJk9eJkW+bnX2VflQXpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=793FvEGRMl6kH9bE4DPbzNbJPvC4hZWY6t2hmcXdals=;
 b=AAjJKaW7d4ScW/MUb98g6WSAQXf1ZK73Tgs2MvnadUejhvXM6buFZgqMgVALrLT69id9O6CkQtMHhPr8iR7uMv9qwLxH8NosP5wekg6gNfo1Kzfx2rtHFQ6yBqcnuKlHuhEBq0Oph11b47qMOkXUPGxQFgEAqJCML3vnNSaxWWQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 12:18:30 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::8e9c:2f3d:9679:942e]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::8e9c:2f3d:9679:942e%5]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 12:18:30 +0000
Content-Type: multipart/alternative;
 boundary="------------IcrG0cpL0BhaVt2EUo2gkChH"
Message-ID: <8c9dc3a4-8b92-4d78-b0c9-f37dfbe1e46c@amd.com>
Date: Tue, 6 Oct 2026 17:48:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] soundwire: amd: Add BRA/BPT firmware download
 support
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, vkoul@kernel.org
Cc: broonie@kernel.org, Sunil-kumar.Dommati@amd.com,
 vijendar.mukunda@amd.com, Mario.Limonciello@amd.com,
 venkataprasad.potturu@amd.com, yung-chuan.liao@linux.intel.com,
 anson.tsao@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Simon Trimmer <simont@opensource.cirrus.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "open list:SOUNDWIRE SUBSYSTEM" <linux-sound@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
 <sound-open-firmware@alsa-project.org>,
 "open list:BPF [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)" <bpf@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:\\bdma_(?:buf|fence|resv)\\b"
 <linux-media@vger.kernel.org>,
 "open list:DMA BUFFER SHARING FRAMEWORK:Keyword:\\bdma_(?:buf|fence|resv)\\b"
 <dri-devel@lists.freedesktop.org>, moderated "list:DMA" BUFFER SHARING
 "FRAMEWORK:Keyword:\\bdma_(?:buf|fence|resv)\\b"
 <linaro-mm-sig@lists.linaro.org>
References: <20261005091620.1390916-1-syed.sabakareem@amd.com>
 <20261005091620.1390916-5-syed.sabakareem@amd.com>
 <b8ab667c-8de2-47db-8fac-49faddd18f1a@linux.dev>
Content-Language: en-US
From: Syed Saba Kareem <syed.sabakareem@amd.com>
In-Reply-To: <b8ab667c-8de2-47db-8fac-49faddd18f1a@linux.dev>
X-ClientProxiedBy: PN4P287CA0045.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::9) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5356:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d392e2b-522f-43c6-73ca-08df23a3ee77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|4143699003|11063799006|6133799003|8096899003|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: G4Y3el+HH21K2CpWNJRoYvqkh1Rs3PaNzXhb5CdVWvWtRPBeDRqMb3Hj97gbCVozKIOdBx8DZVwgrS+ICpR7f5729/bfYsTU704Tzd6t5V6bS7wmy0UKI3WOJnAp3HzP8R2q1PB32E+9VAkC5hxHnqs4lVUT64a6oKA8DKjHPBM3WDNIWrcfjfjbxZhcAOb6YRSrhG59EF4lMfJ53PoS15nPyNE5NBDEbg6h4xWkADfTRM8gVd/xOK0pT+oP0cw2HmKp13faWk37Hr2rmo+SmIydYp81FxKM3yW/lfmNbxttTJDYP14ZMuKI+bDjF5ZiHgKnFgur7lvKHK+q7yP7+2oiTyR+cc1yZDyXu9P7a9y5FF81/ukcA5Rm3tvkakoDHF8FnbPrzcAKlN8f40bodY3MFP43v0zP4M6rT/+QMMLmfFqR93cepR+qFhmX/erHOy23/RQFa6bPNkv012oGTQTY3t1m3ddIqxsHPO/ngsUwdb4PQXN9nrEJtCJ2n5/hXCZhRRaK2ac1Yr6+WDYNbZFCcYGZWg/v5BK/DxkoljadwKaMxHKm533ypMJ8kEnTL6Nqb+I5ZQxlyiJNLl46ka/G9twg5Q6l4Sx+Shr32M+kCbHYiCBOdHZjXzbYgwPENA3R/rPtKbKq1EQPn+NbNjUJefIytxNVNccAzM7U+a4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5356.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(8096899003)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3d5T3Y1VGovUHVTTGRZZE42M0JqVktFek80cjY1UW5QcmQrUEhjdVNyOUVX?=
 =?utf-8?B?U2lBOWw2SWR4eDI2cUpkcXJNYWgwbmFySER4VSszUkFndXRxSFQxc1VKYXIx?=
 =?utf-8?B?RkxBT3BOWXlrTXRmNUxZTTNqTUpSTzNEamdwWHJINWFUdnU0eU1mMlF3SHlI?=
 =?utf-8?B?VS9tbWFJQnJxc2tzYXREc2VSNkxMSVBXbGcrZ3N5U3NIaU9aR0lRc2Z3Qlgv?=
 =?utf-8?B?NlpiZldJdFZkY2ZjTkQrMjlrdUM0aTA1WTJJYmNjd3ZjSjFuLzJNSUZnQmRI?=
 =?utf-8?B?OWZTTEtQUVUyQ0UwTXlicnhHWHpYUW85YjkxbHlkYlFNUVlYYUJTZlJVeThv?=
 =?utf-8?B?OFhTdjhCVGl5c1dxUEpsSFpQQnBhbjMvYU5hV2tIVTIvY2xoSlZ2azl3MVZP?=
 =?utf-8?B?ejdVRWdvRXZTMWVDM1h6VERGRGhsejI5NVh6ZEdhQUh3SEtzWUdxNXRlUHgy?=
 =?utf-8?B?YWw0OWtZS2srbVF6MWtHTHBUSlpBUnEySUVUOGpLVzdEZHBRU0x0RUhpYmNB?=
 =?utf-8?B?YzdnWEFXUTFWbUxLVmJvZlpCVkozMENEbGVsM21pWS9VeGdmanJuK21xWWFO?=
 =?utf-8?B?bUJuT1Z3ZmdkbVJ0dm1jNWVzQ1Z1d0x0bk9PNlM5a1RqdFFNUjV4bFRDNDNq?=
 =?utf-8?B?RmZPK0JWREQ2dHp2T2daZW9TSmVBdFlkUlg3aE1vQXNKeWFIWkE0c1R3L0VP?=
 =?utf-8?B?Q2Q3NGFOamE1SlRIVmpEMENtanQ3RVVldXl5dUtFT3lmazNvcTNlT2drOEN6?=
 =?utf-8?B?TmFRYUI0TzNIeVpHQ2FEZUF0eDZLUlBVNkFHNXZQU2ZMRWdxa3FRc0NEWGlL?=
 =?utf-8?B?b0JpenQ4K1Bjbk4vdVpDMFU0NmNLVnd2M0dnYjZoUk5IT1BzWUswaWFFV3JM?=
 =?utf-8?B?aGI1WlJVajNxRFlWczRTQUVXZTg5cEFRVW54NzR3U0ZLV0NxVVBaa2pDeTY0?=
 =?utf-8?B?NkEzNitCY2hjRCtZcktVMkRiMUpMTTYzaU5NcmFyNE56UXA5L1hqdGNRK0Qv?=
 =?utf-8?B?KzAxY3VLR2VySGNFRjZZNTFLYjl3QVAycVcvZStZQ2gzUmtIdUZMRlVQbTly?=
 =?utf-8?B?L1NMcTJ1aFJ2b01MQVNEVjJScGxORzBMV3FQdVZOWXFyT0pvUTBNT1RNbVJR?=
 =?utf-8?B?OUNHdThqQ2hoWGpWU29Yalh2dDdqSFdIOUd4NDRXRzAzZVJLeXY2NEgwNHpK?=
 =?utf-8?B?cU1PS25IdW9ORHU0RHQvRmsxSER4V2svQUdsZ2YyVENISXc5amJDZU80UzI0?=
 =?utf-8?B?eDNZdnRvaGtLTTFCeVUzT1dPTTRscmxac2xnMVBzVHVxN1FNeHRYZUhXdU1p?=
 =?utf-8?B?TlZNNGRNaDNnNFlhVXE5dzk5cG1BQkh4eUFYOCtqQzBoRitBQ2drS1Fqdm9r?=
 =?utf-8?B?VVQ5NmFuMTErT1QraHB2NVdLQzZjTU1CMXJRa3JCZ0krQ211a1FYNlhLeUJw?=
 =?utf-8?B?ZEg5MytMSks1TVhNNEdyZ0tSQ0NjOVZXZTlxKytyNFVWNzZGMlNrTUkvMkxq?=
 =?utf-8?B?YlJxVzcreER5MThPYS9yZ2JMdUVJWVNsTE5UdG5TL0g2MXFUWFJHSXhSVEdK?=
 =?utf-8?B?MmtDRG9xd1lTS1F0K2krUEhlNmgzTVVpY1VxRm5hd3BSWXRBQjZWbGRBUUIz?=
 =?utf-8?B?QWxEL25xMzRkYXYyYnlmT3c3TEtsN1N5Y1Z6aHh3Y3NHTDRjUStwc1FJWkh2?=
 =?utf-8?B?dWJMRnJScmlDT3kwaDZObHYxRmxyVmM0VTJPQWU1dFB3eXBvTjlIbWY0MXU3?=
 =?utf-8?B?amhoeWtEVkVZeVY0dEVkd1o0RWpBQStRckVqTFgvaE93RkVaM1htZmVnQTVy?=
 =?utf-8?B?OWNkTnFCeVpQSThVOGRtOTU3YUxrL3VveEhweTRkR1lVaHdmK0pwZXhpWGlG?=
 =?utf-8?B?dGNtdmkrajdGTnd6TmRoWG45OEVzdWRDYVVmZVhoTG1BUmdydWNnTlhwVGpR?=
 =?utf-8?B?SlNXL0E3MURwTFdNTkkrYTFya0gxbGhVNC9KQ3BibjBZOEJuRXZDZlVKVHJx?=
 =?utf-8?B?blFHWHV0MVNrN1VQMjM4bHNrNXBFV0xtQ1lBcEFNSjNtaW5UZGJERFNENG1J?=
 =?utf-8?B?Mk5tb3F1MEpFRCttMElTWkhmdmpHNVc2L1AyZUNPb3ZsdkdqNEFTS1RHb1B1?=
 =?utf-8?B?WjI0QURHbjVONGh6OFd4aFhlek52bHliSmJEYTNLWmZrVVpGNEtBR1FIb3V6?=
 =?utf-8?B?dGhhWks4VmNPYXFwTzFnWGc5Y1psaHZzN0ZYbmg4NVVheVlEbGpOOUFKOFVV?=
 =?utf-8?B?NWxFMlFFaXBNNW1qcFZqUWdpWnp3eWoyMEo2a2xlQnA0UXJUWFdDYVE1Wkt6?=
 =?utf-8?B?bGg2OXZFZnp2M0RBK1NTUkZwQ0J2eVRxeEgxQ1BIK3pPM1VoTjdxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d392e2b-522f-43c6-73ca-08df23a3ee77
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 12:18:30.1264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EJTBTFXSTMvKIOZ7Zse2SIDwYLhg41xmN/VnwKuArDnXpMvGHCC2zbGDua7Ls6U7VEAWZVjtGUlz3iKjWehiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521
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

--------------IcrG0cpL0BhaVt2EUo2gkChH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/5/26 17:34, Pierre-Louis Bossart wrote:
> general comment: this patch is quite complex, with code needed for the
> BTP side as well as the DMA side, only interleaved. Is there a way to
> have a 'cleaner' split between DMA functionality on the ACP side and BPT
> on the SoundWire bus side?
>
> Likewise the parts dealing with contiguous and non-contiguous parts of
> the firmware should be handled at a higher level using DMA/BTP support
> lower-level routines.

Agreed, I'll restructure this into three layers for v5: ACP BRA DMA 
primitives (configure descriptor, arm, poll/wait, disarm, deconfigure) 
with no SoundWire-stream knowledge;
SoundWire BPT primitives (open/close stream, enable/disable); and a 
higher-level orchestrator with a dispatcher for the contiguous 
(single-buffer) vs non-contiguous (per-section loop,
with the small-section sdw_nwrite/nread fallback) cases.

One hardware detail I'll preserve and document along the way: the 
SoundWire bank switch is itself the BRA DMA start trigger, and
correct teardown requires disarming the DMA before the disable-path bank 
switch.
So the orchestrator still sequences an ACP call and a SoundWire call in 
a fixed order — the layering makes each side independently readable and 
testable while keeping that ordering contract explicit.

>> +static int amd_sdw_execute_bra_transfer(struct amd_sdw_manager *amd_manager,
>> +					struct sdw_slave *slave,
>> +					bool *dma_unsafe)
>> +{
>> +	struct sdw_bus *bus = &amd_manager->bus;
>> +	u32 i2s_err_offset;
>> +	u32 saved_intr_mask;
>> +	u32 reg_addr, len;
>> +	u32 val;
>> +	int ret, ret_disable;
>> +
>> +	/* Read descriptor regs before enabling the DMA engine. */
>> +	reg_addr = readl(amd_manager->mmio + ACP_SW_BPT_PORT_FIRST_BYTE_ADDR);
>> +	len = readl(amd_manager->mmio + ACP_SW_BRA_TRANSFER_SIZE);
>> +
>> +	i2s_err_offset = (amd_manager->instance == 0) ?
>> +			 ACP_SW_I2S_ERROR_REASON : ACP_P1_SW_I2S_ERROR_REASON;
>> +
>> +	/*
>> +	 * Save and disable the error interrupt mask for manual error
>> +	 * checking.  acp_bra_lock is held across the whole BPT sequence by
>> +	 * amd_sdw_bpt_wait(), which serialises this shared-register
>> +	 * read-modify-write against the other manager instance.
>> +	 */
>> +	saved_intr_mask = readl(amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>> +	writel(0, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>> +	writel(0, amd_manager->acp_mmio + i2s_err_offset);
>> +	writel(0, amd_manager->mmio + ACP_SW_ERROR_REASON1);
>> +
>> +	/* Arm the ACP BPT DMA engine */
>> +	writel(1, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
>> +
>> +	/*
>> +	 * Use the framework's sdw_enable_stream() to write CHANNELEN and
>> +	 * perform a bank switch.  The ACP BPT hardware uses the bank switch
>> +	 * as the trigger to start the DMA transfer.  The framework manages
> do you mean to say
> a) the DMA transfer was armed and started ealier, and the bank switch
> unblocks it, ob
> b) the DMA starts fetching data from memory when the bank switch happens?
>
> the latter case would be quite racy and dependent on the time needed to
> access memory..
>
It's (a). The BRA descriptor (BASE_ADDRESS/TRANSFER_SIZE/FRAME_FORMAT) 
is fully programmed in amd_sdw_config_bra_descriptor(),
and the engine is armed with ACP_SW_BPT_PORT_EN=1, both before 
sdw_enable_stream().
The bank switch is only the trigger for the already-armed engine — it 
doesn't start a cold engine, so there's no memory-latency race on the 
switch.
Once triggered the engine runs autonomously frame by frame, and any 
stall/underrun surfaces as a BRA/I2S error (ACP_SW_I2S_ERROR_REASON / 
ACP_SW_BRA_RESP), not silent corruption.
This is also why, on an aborted or timed-out transfer, the teardown 
clears PORT_EN before the sdw_disable_stream() bank switch — otherwise 
that switch could
re-trigger the armed engine into a buffer we're about to free. I'll 
reword the comment to say the engine is armed here and the bank switch 
only triggers it.
>> +	 * bank state consistently, eliminating the need for a manual bank
>> +	 * switch or DP0 bank mirror.
>> +	 */
>> +	dev_dbg(amd_manager->dev,
>> +		"BPT: pre-enable: curr_bank=%u next_bank=%u BPT_EN_STATUS=0x%x stream_state=%d\n",
>> +		bus->params.curr_bank, bus->params.next_bank,
>> +		readl(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS),
>> +		bus->bpt_stream->state);
>> +
>> +	ret = sdw_enable_stream(bus->bpt_stream);
>> +	if (ret < 0) {
>> +		dev_err(amd_manager->dev,
>> +			"BPT: sdw_enable_stream failed: %d\n", ret);
>> +		/*
>> +		 * Disarm the engine and wait for the port to quiesce before
>> +		 * returning: the caller (amd_sdw_bra_transfer()) then deconfigures
>> +		 * the BRA descriptor unconditionally, zeroing BASE_ADDRESS and
>> +		 * TRANSFER_SIZE, so the port must be idle first -- mirrors the
>> +		 * disable path below.
>> +		 */
>> +		writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
>> +		ret_disable = readl_poll_timeout(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS,
>> +						 val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT);
>> +		if (ret_disable < 0) {
>> +			dev_err(amd_manager->dev, "BPT: PORT_EN disable timeout\n");
>> +			*dma_unsafe = true;
>> +		}
>> +		goto restore_intr;
>> +	}
>> +
>> +	dev_dbg(amd_manager->dev,
>> +		"BPT: DMA started: curr_bank=%u next_bank=%u BPT_EN_STATUS=0x%x stream_state=%d\n",
>> +		bus->params.curr_bank, bus->params.next_bank,
>> +		readl(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS),
>> +		bus->bpt_stream->state);
>> +
>> +	/* Poll DMA_BUSY until transfer completes */
>> +	{
>> +		unsigned long timeout;
>> +
>> +		timeout = jiffies + msecs_to_jiffies(BRA_DMA_TIMEOUT_MS);
>> +		do {
>> +			val = readl(amd_manager->mmio + ACP_SW_BRA_DMA_BUSY);
>> +			/*
>> +			 * Side-effectful read: reading ACP_SW_BRA_CURRENT_TRANSFER_SIZE
>> +			 * advances the BRA DMA engine to the next frame.  The value is
>> +			 * intentionally discarded (hence the (void) cast); removing this
>> +			 * read stalls multi-frame transfers, which then time out.
>> +			 */
>> +			(void)readl(amd_manager->mmio + ACP_SW_BRA_CURRENT_TRANSFER_SIZE);
>> +			if (!(val & 0x01))
>> +				break;
>> +			if (time_after(jiffies, timeout)) {
>> +				/*
>> +				 * Re-sample the busy bit before declaring a
>> +				 * timeout. cond_resched() below can park this
>> +				 * thread for longer than BRA_DMA_TIMEOUT_MS, in
>> +				 * which window the DMA may have completed; without
>> +				 * this final read a finished transfer would be
>> +				 * reported as a false timeout.
>> +				 */
>> +				val = readl(amd_manager->mmio + ACP_SW_BRA_DMA_BUSY);
>> +				if (!(val & 0x01))
>> +					break;
>> +				dev_err(amd_manager->dev,
>> +					"BPT: DMA timeout: periph=0x%08x len=%u EN_STATUS=0x%x RESP=0x%x I2S_ERR=0x%08x\n",
>> +					reg_addr, len,
>> +					readl(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS),
>> +					readl(amd_manager->mmio + ACP_SW_BRA_RESP),
>> +					readl(amd_manager->acp_mmio + i2s_err_offset));
>> +				ret = -ETIMEDOUT;
>> +				break;
>> +			}
>> +			/*
>> +			 * Runs in process context. Yield the CPU so a
>> +			 * multi-frame transfer cannot busy-spin for up to
>> +			 * BRA_DMA_TIMEOUT_MS and trip the soft lockup
>> +			 * watchdog on non-preemptible kernels. cond_resched()
>> +			 * keeps the poll cadence tight -- reading
>> +			 * ACP_SW_BRA_CURRENT_TRANSFER_SIZE every iteration is
>> +			 * required to advance the DMA engine between frames,
>> +			 * so usleep_range() (which would space out the reads)
>> +			 * is deliberately not used here.
>> +			 */
>> +			cond_resched();
>> +		} while (1);
>> +	}
>> +
>> +	/* Check for I2S/BRA errors */
>> +	val = readl(amd_manager->acp_mmio + i2s_err_offset);
>> +	if (val & AMD_SDW_BRA_I2S_ERROR_MASK) {
>> +		dev_err(amd_manager->dev,
>> +			"BPT: BRA failed I2S_ERROR_REASON=0x%08x (NAK=%u Clash=%u HdrResp=%u FtrResp=%u CRC=%u DMA=%u Cmd=%u)\n",
>> +			val,
>> +			!!(val & BIT(18)), !!(val & BIT(19)),
>> +			!!(val & BIT(26)), !!(val & BIT(27)),
>> +			!!(val & BIT(28)), !!(val & BIT(29)), !!(val & BIT(30)));
>> +		writel(0, amd_manager->acp_mmio + i2s_err_offset);
>> +		if (!ret)
>> +			ret = -EIO;
>> +	} else if (!ret) {
>> +		dev_dbg(amd_manager->dev,
>> +			"BPT: DMA done: periph=0x%08x len=%u\n", reg_addr, len);
>> +	}
>> +
>> +	/*
>> +	 * On an aborted or timed-out transfer the ACP BPT DMA engine can still
>> +	 * be armed (PORT_EN=1, DMA_BUSY=1). sdw_disable_stream() below performs
>> +	 * a bank switch, which is the BPT DMA start trigger, so disarm the engine
>> +	 * first -- otherwise the bank switch could (re)start a DMA write into
>> +	 * dma_buf, which amd_sdw_bpt_wait() frees as soon as this transfer
>> +	 * returns. On the success path the DMA has already completed, so this
>> +	 * early clear is a no-op.
>> +	 */
>> +	if (ret < 0)
>> +		writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
>> +
>> +	/*
>> +	 * Disable the stream via framework (writes CHANNELEN=0 + bank switch).
>> +	 * This cleanly stops the port and keeps bank state consistent.
>> +	 * Propagate a disable failure: it leaves the stream in
>> +	 * SDW_STREAM_ENABLED, and sdw_enable_stream() returns 0 early for an
>> +	 * already-ENABLED stream without the bank switch that triggers the BRA
>> +	 * DMA, so the next section would be silently skipped rather than
>> +	 * transferred.  Report the failure to the caller so it stops instead of
>> +	 * chaining a section whose DMA never starts.
>> +	 */
>> +	ret_disable = sdw_disable_stream(bus->bpt_stream);
>> +	if (ret_disable < 0) {
>> +		dev_err(amd_manager->dev, "BPT: sdw_disable_stream failed: %d\n",
>> +			ret_disable);
>> +		if (!ret)
>> +			ret = ret_disable;
>> +	}
>> +
>> +	dev_dbg(amd_manager->dev,
>> +		"BPT: post-disable: curr_bank=%u next_bank=%u stream_state=%d\n",
>> +		bus->params.curr_bank, bus->params.next_bank,
>> +		bus->bpt_stream->state);
>> +
>> +	/*
>> +	 * Disarm the ACP BPT DMA engine and wait for the port to quiesce.
>> +	 * Like the manager enable/disable sequence (ACP_SW_EN paired with
>> +	 * ACP_SW_EN_STATUS), ACP_SW_BPT_PORT_EN_STATUS reflects the real port
>> +	 * state, so polling it here guarantees a non-contiguous transfer's next
>> +	 * section cannot re-arm PORT_EN before the current one has torn down.
>> +	 */
>> +	writel(0, amd_manager->mmio + ACP_SW_BPT_PORT_EN);
>> +	ret_disable = readl_poll_timeout(amd_manager->mmio + ACP_SW_BPT_PORT_EN_STATUS,
>> +					 val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT);
>> +	if (ret_disable < 0) {
>> +		dev_err(amd_manager->dev, "BPT: PORT_EN disable timeout\n");
>> +		if (!ret)
>> +			ret = ret_disable;
>> +		*dma_unsafe = true;
>> +	}
>> +	writel(0, amd_manager->acp_mmio + i2s_err_offset);
>> +	writel(0, amd_manager->mmio + ACP_SW_ERROR_REASON1);
>> +	/*
>> +	 * Clearing the immediate-command response-valid status races with the
>> +	 * immediate-command path (amd_sdw_send_cmd_get_resp()), which polls and
>> +	 * clears the same ACP_SW_IMM_CMD_STS bit under bus->msg_lock. The BPT DMA
>> +	 * poll loop above drops all locks, so a concurrent slave enumeration or
>> +	 * register access (amd_sdw_work / IRQ thread / codec regmap) can be
>> +	 * mid-command here. Take msg_lock so this teardown clear cannot erase a
>> +	 * response the command path has not yet consumed, which would make that
>> +	 * command time out. This msg_lock nests inside acp_bra_lock and bpt_lock,
>> +	 * both already held by the enclosing amd_sdw_bpt_wait(), preserving the
>> +	 * bpt_lock -> acp_bra_lock -> msg_lock order. do_bank_switch() inside
>> +	 * sdw_enable_stream()/sdw_disable_stream() only takes msg_lock for
>> +	 * multi-link managers, so this single-link manager establishes that order
>> +	 * via the explicit msg_lock here and in the non-contiguous
>> +	 * sdw_nwrite_no_pm()/sdw_nread_no_pm() fallback.
>> +	 */
>> +	mutex_lock(&bus->msg_lock);
>> +	writel(AMD_SDW_IMM_RES_VALID, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>> +	mutex_unlock(&bus->msg_lock);
>> +
>> +restore_intr:
>> +	writel(saved_intr_mask, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
>> +	return ret;
>> +}
> [...]
>
>> +static int amd_sdw_bpt_wait(struct sdw_bus *bus,
>> +			    struct sdw_slave *slave,
>> +			    struct sdw_bpt_msg *msg)
>> +{
>> +	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
>> +	bool is_write = (msg->flags & SDW_MSG_FLAG_WRITE);
>> +	struct amd_bra_params prep_params = {0};
>> +	u32 acp_sys_addr;
>> +	dma_addr_t dma_addr = 0;
>> +	u8 *dma_buf = NULL;
>> +	size_t offset = 0;
>> +	size_t total_len = 0;
>> +	int ret = 0;
>> +	int i;
>> +	bool dma_unsafe = false;
>> +
>> +	for (i = 0; i < msg->sections; i++) {
>> +		if (msg->sec[i].len > SDW_BPT_MSG_MAX_BYTES - total_len) {
>> +			dev_err(amd_manager->dev,
>> +				"BPT msg length exceeds maximum %d bytes\n",
>> +				SDW_BPT_MSG_MAX_BYTES);
>> +			return -EINVAL;
>> +		}
>> +		total_len += msg->sec[i].len;
>> +	}
>> +
>> +	if (total_len < AMD_BPT_MSG_BYTE_MIN) {
>> +		dev_err(amd_manager->dev,
>> +			"BPT msg length %zu < minimum %d bytes\n",
>> +			total_len, AMD_BPT_MSG_BYTE_MIN);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Take the runtime-PM reference that keeps the bus clock alive before
>> +	 * acquiring bpt_lock, not after.  When the manager is runtime
>> +	 * suspended, pm_runtime_get_sync() runs amd_resume_runtime()
>> +	 * synchronously in this task, and that callback acquires bpt_lock to
>> +	 * clear bpt_disabled.  Taking the reference while already holding
>> +	 * bpt_lock would therefore deadlock against ourselves.
>> +	 */
>> +	ret = pm_runtime_get_sync(amd_manager->dev);
>> +	/*
>> +	 * -EACCES only occurs when runtime PM is disabled, which for this
>> +	 * device happens across the system suspend/resume window.  amd_suspend()
>> +	 * sets bpt_disabled before the clock is stopped and amd_resume_runtime()
>> +	 * clears it only once the clock is back, so the bpt_disabled check below
>> +	 * rejects the transfer with -ESHUTDOWN before any BRA access whenever the
>> +	 * clock could be down.  A merely runtime-suspended manager (clock stopped,
>> +	 * PM still enabled) is resumed by the get above and returns success, not
>> +	 * -EACCES; tolerating -EACCES therefore never drives the BRA engine on a
>> +	 * stopped clock.
>> +	 */
>> +	if (ret < 0 && ret != -EACCES) {
>> +		pm_runtime_put_noidle(amd_manager->dev);
>> +		dev_err(amd_manager->dev, "BPT: pm_runtime_get failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * The ACP BRA engine is a single shared resource.  Serialise all BPT
>> +	 * transfers so concurrent slave probes do not race over the hardware.
>> +	 */
>> +	mutex_lock(&amd_manager->bpt_lock);
>> +
>> +	/*
>> +	 * Refuse the transfer if the bus is being (or has been) clock-stopped
>> +	 * for system suspend.  Driving the BRA/command channel while the clock
>> +	 * is stopping wedges the channel and leaves the peripheral unable to
>> +	 * re-enumerate on resume; the codec retries once it re-attaches.
>> +	 */
>> +	if (amd_manager->bpt_disabled) {
>> +		mutex_unlock(&amd_manager->bpt_lock);
>> +		pm_runtime_mark_last_busy(amd_manager->dev);
>> +		pm_runtime_put_autosuspend(amd_manager->dev);
>> +		return -ESHUTDOWN;
>> +	}
>> +
>> +	/* BRA always uses all available data columns (1..NC-1). */
>> +	amd_manager->bra_hstart = 1;
>> +	amd_manager->bra_hstop  = bus->params.col - 1;
>> +
>> +	/*
>> +	 * Open the BPT stream so the framework stream state machine tracks the
>> +	 * transfer.  Slave DP0 is prepared below before bra_transfer().
>> +	 */
>> +	ret = amd_sdw_bpt_open_stream(amd_manager, slave, msg);
>> +	if (ret < 0)
>> +		goto close_stream;
>> +
>> +	/* Allocate single DMA buffer for entire BPT message */
>> +	dma_buf = dma_alloc_coherent(amd_manager->dev->parent, total_len,
>> +				     &dma_addr, GFP_KERNEL);
>> +	if (!dma_buf) {
>> +		ret = -ENOMEM;
>> +		goto close_stream;
>> +	}
>> +
>> +	/*
>> +	 * The ATU GRP_1 and scratch PTE registers programmed here are
>> +	 * ACP-global and shared by both SoundWire manager instances, as is the
>> +	 * BRA DMA engine that reads through them.  bpt_lock is per-manager and
>> +	 * does not serialise across instances, so hold the ACP-wide
>> +	 * acp_bra_lock across the whole configure -> transfer -> deconfigure
>> +	 * sequence to stop the other instance reprogramming the shared PTEs
>> +	 * mid-transfer.
> In that case, what is the point of having a per-instance btp_lock as well?
>
> It seems from the comment that only *one* BTP transfer can take place
> across all manager instances, which defeats the purpose of a
> per-instance lock, no?
> What I am missing?

You're right that the transfer itself is serialized ACP-wide: that's 
acp_bra_lock, held only across configure → transfer → deconfigure, 
because the ATU PTEs and
  the BRA DMA engine are single resources shared by both links. bpt_lock 
is per-link and has a different scope rather than a different transfer 
window:

  * It guards bpt_disabled, which is per-link
    suspend/clock-stop/runtime-PM state — each link's
    amd_suspend()/clock-stop sets it and amd_resume_runtime() clears it
    under bpt_lock. A per-link flag doesn't belong under an ACP-global lock.
  * It serializes multiple BPT requests to the same link and lets that
    link's suspend path drain an in-flight transfer, without reaching
    for the global lock.
  * It keeps acp_bra_lock's hold time minimal: the per-link
    setup/teardown (open_stream, dma_alloc, the PM get/put, the
    bpt_disabled check) runs under bpt_lock but outside acp_bra_lock, so
    the other link contends for the global lock only during the actual
    shared-hardware window, not the whole sequence.

Folding everything onto acp_bra_lock would mean the global lock has to 
cover each link's full transfer path including its runtime-PM callbacks, 
i.e. one link's PM transitions
  would serialize against the other link's transfer — a scope mismatch 
and a longer global hold time. So the two are intentionally different 
scopes: bpt_lock = per-link lifecycle/PM, acp_bra_lock = ACP-global 
shared hardware.
Today the comment only documents acp_bra_lock; I'll expand it to cover both.

--------------IcrG0cpL0BhaVt2EUo2gkChH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/5/26 17:34, Pierre-Louis Bossart
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b8ab667c-8de2-47db-8fac-49faddd18f1a@linux.dev">
      <pre wrap="" class="moz-quote-pre">general comment: this patch is quite complex, with code needed for the
BTP side as well as the DMA side, only interleaved. Is there a way to
have a 'cleaner' split between DMA functionality on the ACP side and BPT
on the SoundWire bus side?

Likewise the parts dealing with contiguous and non-contiguous parts of
the firmware should be handled at a higher level using DMA/BTP support
lower-level routines.</pre>
    </blockquote>
    <p>Agreed, I'll restructure this into three layers for v5: ACP BRA
      DMA primitives (configure descriptor, arm, poll/wait, disarm,
      deconfigure) with no SoundWire-stream knowledge;&nbsp;<br>
      SoundWire BPT primitives (open/close stream, enable/disable); and
      a higher-level orchestrator with a dispatcher for the contiguous
      (single-buffer) vs non-contiguous (per-section loop,&nbsp;<br>
      with the small-section sdw_nwrite/nread fallback) cases.</p>
    <p>One hardware detail I'll preserve and document along the way: the
      SoundWire bank switch is itself the BRA DMA start trigger,&nbsp;and&nbsp;<br>
      correct teardown requires disarming the DMA before the
      disable-path bank switch.&nbsp;<br>
      So the orchestrator still sequences an ACP call and a SoundWire
      call in a fixed order — the layering makes each side independently
      readable and testable while keeping that ordering contract
      explicit.</p>
    <blockquote type="cite" cite="mid:b8ab667c-8de2-47db-8fac-49faddd18f1a@linux.dev">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+static int amd_sdw_execute_bra_transfer(struct amd_sdw_manager *amd_manager,
+					struct sdw_slave *slave,
+					bool *dma_unsafe)
+{
+	struct sdw_bus *bus = &amp;amd_manager-&gt;bus;
+	u32 i2s_err_offset;
+	u32 saved_intr_mask;
+	u32 reg_addr, len;
+	u32 val;
+	int ret, ret_disable;
+
+	/* Read descriptor regs before enabling the DMA engine. */
+	reg_addr = readl(amd_manager-&gt;mmio + ACP_SW_BPT_PORT_FIRST_BYTE_ADDR);
+	len = readl(amd_manager-&gt;mmio + ACP_SW_BRA_TRANSFER_SIZE);
+
+	i2s_err_offset = (amd_manager-&gt;instance == 0) ?
+			 ACP_SW_I2S_ERROR_REASON : ACP_P1_SW_I2S_ERROR_REASON;
+
+	/*
+	 * Save and disable the error interrupt mask for manual error
+	 * checking.  acp_bra_lock is held across the whole BPT sequence by
+	 * amd_sdw_bpt_wait(), which serialises this shared-register
+	 * read-modify-write against the other manager instance.
+	 */
+	saved_intr_mask = readl(amd_manager-&gt;mmio + ACP_SW_ERROR_INTR_MASK);
+	writel(0, amd_manager-&gt;mmio + ACP_SW_ERROR_INTR_MASK);
+	writel(0, amd_manager-&gt;acp_mmio + i2s_err_offset);
+	writel(0, amd_manager-&gt;mmio + ACP_SW_ERROR_REASON1);
+
+	/* Arm the ACP BPT DMA engine */
+	writel(1, amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN);
+
+	/*
+	 * Use the framework's sdw_enable_stream() to write CHANNELEN and
+	 * perform a bank switch.  The ACP BPT hardware uses the bank switch
+	 * as the trigger to start the DMA transfer.  The framework manages
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
do you mean to say
a) the DMA transfer was armed and started ealier, and the bank switch
unblocks it, ob
b) the DMA starts fetching data from memory when the bank switch happens?

the latter case would be quite racy and dependent on the time needed to
access memory..

</pre>
    </blockquote>
    It's (a). The BRA descriptor
    (BASE_ADDRESS/TRANSFER_SIZE/FRAME_FORMAT) is fully programmed in
    amd_sdw_config_bra_descriptor(),&nbsp;<br>
    and the engine is armed with ACP_SW_BPT_PORT_EN=1, both before
    sdw_enable_stream().&nbsp;<br>
    The bank switch is only the trigger for the already-armed engine —
    it doesn't start a cold engine, so there's no memory-latency race on
    the switch.&nbsp;<br>
    Once triggered the engine runs autonomously frame by frame, and any
    stall/underrun surfaces as a BRA/I2S error (ACP_SW_I2S_ERROR_REASON
    / ACP_SW_BRA_RESP), not silent corruption.<br>
    This is also why, on an aborted or timed-out transfer, the teardown
    clears PORT_EN before the sdw_disable_stream() bank switch —
    otherwise that switch could&nbsp;<br>
    re-trigger the armed engine into a buffer we're about to free. I'll
    reword the comment to say the engine is armed here and the bank
    switch only triggers it.
    <blockquote type="cite" cite="mid:b8ab667c-8de2-47db-8fac-49faddd18f1a@linux.dev">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	 * bank state consistently, eliminating the need for a manual bank
+	 * switch or DP0 bank mirror.
+	 */
+	dev_dbg(amd_manager-&gt;dev,
+		&quot;BPT: pre-enable: curr_bank=%u next_bank=%u BPT_EN_STATUS=0x%x stream_state=%d\n&quot;,
+		bus-&gt;params.curr_bank, bus-&gt;params.next_bank,
+		readl(amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN_STATUS),
+		bus-&gt;bpt_stream-&gt;state);
+
+	ret = sdw_enable_stream(bus-&gt;bpt_stream);
+	if (ret &lt; 0) {
+		dev_err(amd_manager-&gt;dev,
+			&quot;BPT: sdw_enable_stream failed: %d\n&quot;, ret);
+		/*
+		 * Disarm the engine and wait for the port to quiesce before
+		 * returning: the caller (amd_sdw_bra_transfer()) then deconfigures
+		 * the BRA descriptor unconditionally, zeroing BASE_ADDRESS and
+		 * TRANSFER_SIZE, so the port must be idle first -- mirrors the
+		 * disable path below.
+		 */
+		writel(0, amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN);
+		ret_disable = readl_poll_timeout(amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN_STATUS,
+						 val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT);
+		if (ret_disable &lt; 0) {
+			dev_err(amd_manager-&gt;dev, &quot;BPT: PORT_EN disable timeout\n&quot;);
+			*dma_unsafe = true;
+		}
+		goto restore_intr;
+	}
+
+	dev_dbg(amd_manager-&gt;dev,
+		&quot;BPT: DMA started: curr_bank=%u next_bank=%u BPT_EN_STATUS=0x%x stream_state=%d\n&quot;,
+		bus-&gt;params.curr_bank, bus-&gt;params.next_bank,
+		readl(amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN_STATUS),
+		bus-&gt;bpt_stream-&gt;state);
+
+	/* Poll DMA_BUSY until transfer completes */
+	{
+		unsigned long timeout;
+
+		timeout = jiffies + msecs_to_jiffies(BRA_DMA_TIMEOUT_MS);
+		do {
+			val = readl(amd_manager-&gt;mmio + ACP_SW_BRA_DMA_BUSY);
+			/*
+			 * Side-effectful read: reading ACP_SW_BRA_CURRENT_TRANSFER_SIZE
+			 * advances the BRA DMA engine to the next frame.  The value is
+			 * intentionally discarded (hence the (void) cast); removing this
+			 * read stalls multi-frame transfers, which then time out.
+			 */
+			(void)readl(amd_manager-&gt;mmio + ACP_SW_BRA_CURRENT_TRANSFER_SIZE);
+			if (!(val &amp; 0x01))
+				break;
+			if (time_after(jiffies, timeout)) {
+				/*
+				 * Re-sample the busy bit before declaring a
+				 * timeout. cond_resched() below can park this
+				 * thread for longer than BRA_DMA_TIMEOUT_MS, in
+				 * which window the DMA may have completed; without
+				 * this final read a finished transfer would be
+				 * reported as a false timeout.
+				 */
+				val = readl(amd_manager-&gt;mmio + ACP_SW_BRA_DMA_BUSY);
+				if (!(val &amp; 0x01))
+					break;
+				dev_err(amd_manager-&gt;dev,
+					&quot;BPT: DMA timeout: periph=0x%08x len=%u EN_STATUS=0x%x RESP=0x%x I2S_ERR=0x%08x\n&quot;,
+					reg_addr, len,
+					readl(amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN_STATUS),
+					readl(amd_manager-&gt;mmio + ACP_SW_BRA_RESP),
+					readl(amd_manager-&gt;acp_mmio + i2s_err_offset));
+				ret = -ETIMEDOUT;
+				break;
+			}
+			/*
+			 * Runs in process context. Yield the CPU so a
+			 * multi-frame transfer cannot busy-spin for up to
+			 * BRA_DMA_TIMEOUT_MS and trip the soft lockup
+			 * watchdog on non-preemptible kernels. cond_resched()
+			 * keeps the poll cadence tight -- reading
+			 * ACP_SW_BRA_CURRENT_TRANSFER_SIZE every iteration is
+			 * required to advance the DMA engine between frames,
+			 * so usleep_range() (which would space out the reads)
+			 * is deliberately not used here.
+			 */
+			cond_resched();
+		} while (1);
+	}
+
+	/* Check for I2S/BRA errors */
+	val = readl(amd_manager-&gt;acp_mmio + i2s_err_offset);
+	if (val &amp; AMD_SDW_BRA_I2S_ERROR_MASK) {
+		dev_err(amd_manager-&gt;dev,
+			&quot;BPT: BRA failed I2S_ERROR_REASON=0x%08x (NAK=%u Clash=%u HdrResp=%u FtrResp=%u CRC=%u DMA=%u Cmd=%u)\n&quot;,
+			val,
+			!!(val &amp; BIT(18)), !!(val &amp; BIT(19)),
+			!!(val &amp; BIT(26)), !!(val &amp; BIT(27)),
+			!!(val &amp; BIT(28)), !!(val &amp; BIT(29)), !!(val &amp; BIT(30)));
+		writel(0, amd_manager-&gt;acp_mmio + i2s_err_offset);
+		if (!ret)
+			ret = -EIO;
+	} else if (!ret) {
+		dev_dbg(amd_manager-&gt;dev,
+			&quot;BPT: DMA done: periph=0x%08x len=%u\n&quot;, reg_addr, len);
+	}
+
+	/*
+	 * On an aborted or timed-out transfer the ACP BPT DMA engine can still
+	 * be armed (PORT_EN=1, DMA_BUSY=1). sdw_disable_stream() below performs
+	 * a bank switch, which is the BPT DMA start trigger, so disarm the engine
+	 * first -- otherwise the bank switch could (re)start a DMA write into
+	 * dma_buf, which amd_sdw_bpt_wait() frees as soon as this transfer
+	 * returns. On the success path the DMA has already completed, so this
+	 * early clear is a no-op.
+	 */
+	if (ret &lt; 0)
+		writel(0, amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN);
+
+	/*
+	 * Disable the stream via framework (writes CHANNELEN=0 + bank switch).
+	 * This cleanly stops the port and keeps bank state consistent.
+	 * Propagate a disable failure: it leaves the stream in
+	 * SDW_STREAM_ENABLED, and sdw_enable_stream() returns 0 early for an
+	 * already-ENABLED stream without the bank switch that triggers the BRA
+	 * DMA, so the next section would be silently skipped rather than
+	 * transferred.  Report the failure to the caller so it stops instead of
+	 * chaining a section whose DMA never starts.
+	 */
+	ret_disable = sdw_disable_stream(bus-&gt;bpt_stream);
+	if (ret_disable &lt; 0) {
+		dev_err(amd_manager-&gt;dev, &quot;BPT: sdw_disable_stream failed: %d\n&quot;,
+			ret_disable);
+		if (!ret)
+			ret = ret_disable;
+	}
+
+	dev_dbg(amd_manager-&gt;dev,
+		&quot;BPT: post-disable: curr_bank=%u next_bank=%u stream_state=%d\n&quot;,
+		bus-&gt;params.curr_bank, bus-&gt;params.next_bank,
+		bus-&gt;bpt_stream-&gt;state);
+
+	/*
+	 * Disarm the ACP BPT DMA engine and wait for the port to quiesce.
+	 * Like the manager enable/disable sequence (ACP_SW_EN paired with
+	 * ACP_SW_EN_STATUS), ACP_SW_BPT_PORT_EN_STATUS reflects the real port
+	 * state, so polling it here guarantees a non-contiguous transfer's next
+	 * section cannot re-arm PORT_EN before the current one has torn down.
+	 */
+	writel(0, amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN);
+	ret_disable = readl_poll_timeout(amd_manager-&gt;mmio + ACP_SW_BPT_PORT_EN_STATUS,
+					 val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT);
+	if (ret_disable &lt; 0) {
+		dev_err(amd_manager-&gt;dev, &quot;BPT: PORT_EN disable timeout\n&quot;);
+		if (!ret)
+			ret = ret_disable;
+		*dma_unsafe = true;
+	}
+	writel(0, amd_manager-&gt;acp_mmio + i2s_err_offset);
+	writel(0, amd_manager-&gt;mmio + ACP_SW_ERROR_REASON1);
+	/*
+	 * Clearing the immediate-command response-valid status races with the
+	 * immediate-command path (amd_sdw_send_cmd_get_resp()), which polls and
+	 * clears the same ACP_SW_IMM_CMD_STS bit under bus-&gt;msg_lock. The BPT DMA
+	 * poll loop above drops all locks, so a concurrent slave enumeration or
+	 * register access (amd_sdw_work / IRQ thread / codec regmap) can be
+	 * mid-command here. Take msg_lock so this teardown clear cannot erase a
+	 * response the command path has not yet consumed, which would make that
+	 * command time out. This msg_lock nests inside acp_bra_lock and bpt_lock,
+	 * both already held by the enclosing amd_sdw_bpt_wait(), preserving the
+	 * bpt_lock -&gt; acp_bra_lock -&gt; msg_lock order. do_bank_switch() inside
+	 * sdw_enable_stream()/sdw_disable_stream() only takes msg_lock for
+	 * multi-link managers, so this single-link manager establishes that order
+	 * via the explicit msg_lock here and in the non-contiguous
+	 * sdw_nwrite_no_pm()/sdw_nread_no_pm() fallback.
+	 */
+	mutex_lock(&amp;bus-&gt;msg_lock);
+	writel(AMD_SDW_IMM_RES_VALID, amd_manager-&gt;mmio + ACP_SW_IMM_CMD_STS);
+	mutex_unlock(&amp;bus-&gt;msg_lock);
+
+restore_intr:
+	writel(saved_intr_mask, amd_manager-&gt;mmio + ACP_SW_ERROR_INTR_MASK);
+	return ret;
+}
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
[...]

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+static int amd_sdw_bpt_wait(struct sdw_bus *bus,
+			    struct sdw_slave *slave,
+			    struct sdw_bpt_msg *msg)
+{
+	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
+	bool is_write = (msg-&gt;flags &amp; SDW_MSG_FLAG_WRITE);
+	struct amd_bra_params prep_params = {0};
+	u32 acp_sys_addr;
+	dma_addr_t dma_addr = 0;
+	u8 *dma_buf = NULL;
+	size_t offset = 0;
+	size_t total_len = 0;
+	int ret = 0;
+	int i;
+	bool dma_unsafe = false;
+
+	for (i = 0; i &lt; msg-&gt;sections; i++) {
+		if (msg-&gt;sec[i].len &gt; SDW_BPT_MSG_MAX_BYTES - total_len) {
+			dev_err(amd_manager-&gt;dev,
+				&quot;BPT msg length exceeds maximum %d bytes\n&quot;,
+				SDW_BPT_MSG_MAX_BYTES);
+			return -EINVAL;
+		}
+		total_len += msg-&gt;sec[i].len;
+	}
+
+	if (total_len &lt; AMD_BPT_MSG_BYTE_MIN) {
+		dev_err(amd_manager-&gt;dev,
+			&quot;BPT msg length %zu &lt; minimum %d bytes\n&quot;,
+			total_len, AMD_BPT_MSG_BYTE_MIN);
+		return -EINVAL;
+	}
+
+	/*
+	 * Take the runtime-PM reference that keeps the bus clock alive before
+	 * acquiring bpt_lock, not after.  When the manager is runtime
+	 * suspended, pm_runtime_get_sync() runs amd_resume_runtime()
+	 * synchronously in this task, and that callback acquires bpt_lock to
+	 * clear bpt_disabled.  Taking the reference while already holding
+	 * bpt_lock would therefore deadlock against ourselves.
+	 */
+	ret = pm_runtime_get_sync(amd_manager-&gt;dev);
+	/*
+	 * -EACCES only occurs when runtime PM is disabled, which for this
+	 * device happens across the system suspend/resume window.  amd_suspend()
+	 * sets bpt_disabled before the clock is stopped and amd_resume_runtime()
+	 * clears it only once the clock is back, so the bpt_disabled check below
+	 * rejects the transfer with -ESHUTDOWN before any BRA access whenever the
+	 * clock could be down.  A merely runtime-suspended manager (clock stopped,
+	 * PM still enabled) is resumed by the get above and returns success, not
+	 * -EACCES; tolerating -EACCES therefore never drives the BRA engine on a
+	 * stopped clock.
+	 */
+	if (ret &lt; 0 &amp;&amp; ret != -EACCES) {
+		pm_runtime_put_noidle(amd_manager-&gt;dev);
+		dev_err(amd_manager-&gt;dev, &quot;BPT: pm_runtime_get failed: %d\n&quot;, ret);
+		return ret;
+	}
+
+	/*
+	 * The ACP BRA engine is a single shared resource.  Serialise all BPT
+	 * transfers so concurrent slave probes do not race over the hardware.
+	 */
+	mutex_lock(&amp;amd_manager-&gt;bpt_lock);
+
+	/*
+	 * Refuse the transfer if the bus is being (or has been) clock-stopped
+	 * for system suspend.  Driving the BRA/command channel while the clock
+	 * is stopping wedges the channel and leaves the peripheral unable to
+	 * re-enumerate on resume; the codec retries once it re-attaches.
+	 */
+	if (amd_manager-&gt;bpt_disabled) {
+		mutex_unlock(&amp;amd_manager-&gt;bpt_lock);
+		pm_runtime_mark_last_busy(amd_manager-&gt;dev);
+		pm_runtime_put_autosuspend(amd_manager-&gt;dev);
+		return -ESHUTDOWN;
+	}
+
+	/* BRA always uses all available data columns (1..NC-1). */
+	amd_manager-&gt;bra_hstart = 1;
+	amd_manager-&gt;bra_hstop  = bus-&gt;params.col - 1;
+
+	/*
+	 * Open the BPT stream so the framework stream state machine tracks the
+	 * transfer.  Slave DP0 is prepared below before bra_transfer().
+	 */
+	ret = amd_sdw_bpt_open_stream(amd_manager, slave, msg);
+	if (ret &lt; 0)
+		goto close_stream;
+
+	/* Allocate single DMA buffer for entire BPT message */
+	dma_buf = dma_alloc_coherent(amd_manager-&gt;dev-&gt;parent, total_len,
+				     &amp;dma_addr, GFP_KERNEL);
+	if (!dma_buf) {
+		ret = -ENOMEM;
+		goto close_stream;
+	}
+
+	/*
+	 * The ATU GRP_1 and scratch PTE registers programmed here are
+	 * ACP-global and shared by both SoundWire manager instances, as is the
+	 * BRA DMA engine that reads through them.  bpt_lock is per-manager and
+	 * does not serialise across instances, so hold the ACP-wide
+	 * acp_bra_lock across the whole configure -&gt; transfer -&gt; deconfigure
+	 * sequence to stop the other instance reprogramming the shared PTEs
+	 * mid-transfer.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
In that case, what is the point of having a per-instance btp_lock as well?

It seems from the comment that only *one* BTP transfer can take place
across all manager instances, which defeats the purpose of a
per-instance lock, no?
What I am missing?</pre>
    </blockquote>
    <p>You're right that the transfer itself is serialized ACP-wide:
      that's acp_bra_lock, held only across configure → transfer →
      deconfigure, because the ATU PTEs and<br>
      &nbsp;the BRA DMA engine are single resources shared by both links.
      bpt_lock is per-link and has a different scope rather than a
      different transfer window:</p>
    <ul>
      <li>It guards bpt_disabled, which is per-link
        suspend/clock-stop/runtime-PM state — each link's
        amd_suspend()/clock-stop sets it and amd_resume_runtime() clears
        it under bpt_lock. A per-link flag doesn't belong under an
        ACP-global lock.</li>
      <li>It serializes multiple BPT requests to the same link and lets
        that link's suspend path drain an in-flight transfer, without
        reaching for the global lock.</li>
      <li>It keeps acp_bra_lock's hold time minimal: the per-link
        setup/teardown (open_stream, dma_alloc, the PM get/put, the
        bpt_disabled check) runs under bpt_lock but outside
        acp_bra_lock, so the other link contends for the global lock
        only during the actual shared-hardware window, not the whole
        sequence.</li>
    </ul>
    <p>Folding everything onto acp_bra_lock would mean the global lock
      has to cover each link's full transfer path including its
      runtime-PM callbacks, i.e. one link's PM transitions<br>
      &nbsp;would serialize against the other link's transfer — a scope
      mismatch and a longer global hold time. So the two are
      intentionally different scopes: bpt_lock = per-link lifecycle/PM,
      acp_bra_lock = ACP-global shared hardware.&nbsp;<br>
      Today the comment only documents acp_bra_lock; I'll expand it to
      cover both.</p>
    <blockquote type="cite" cite="mid:b8ab667c-8de2-47db-8fac-49faddd18f1a@linux.dev">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------IcrG0cpL0BhaVt2EUo2gkChH--
