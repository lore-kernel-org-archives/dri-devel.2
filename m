Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62479CDB46B
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 10:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC63D10E1DC;
	Sat, 20 Jun 2026 10:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mVdXZ6kz";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B87C10E1DC
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 10:48:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZw9zSMUPjyVy6vBamWTrKGaFiliAuTFxoeVy682pTdOy4cJQahTVIu6+Sl4Ps7koQb6PC4jdGAErAZlw+jwG6+DuVGhdymDBiZoSrE7f/RxBeSweW2E6QySkenvz1Px/wx7rHlfaXw2N9/bnzoaQsiuu1cU3hh/v5jf2nbLz3ZJlIll1c0Lkh+RDetH0D0hH3qyT1r++j57U879epOe/pZGVcqlW0gD+lgPS3hmik+FPVrsmHFfairoO1piAmAdo9k7AtocpWICOiaGZQvQ4/7RfR0gidRzWL4H8M8EXUOHC05rfrHNjYrvEZby31jFu2LSeQ1UMGdAPo10Ltkd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jx52+7BxezvTZNvb5gtiWzX8yRdYsaGHElz07pmbuPM=;
 b=nxdBmX4pdfis55pH01AOmnZhyHtgLLnZ4sgfHV7AidNSIFcxNrHh8tEMfCbmYjezh49BZ2c8F1ckwraq+T4JBX93GsKL6JZw226joN38RNGKBmS/VKvka+4Ro39dT35APvwNKPn8P3eDStqhC16m+4pSJBOYyci3YCsfDHyCUdX5Nvhw2QPkmB37zf3pGZF2YTSPsxR82+OIWYwtPZKOeHk8wdItC5seDR4wwqSmoruiCHQPJQ7NdDQ00a8FB3T2dnNPjtUOiNv/nGeYKh2yVWMNU4O9yOM+kdKfNY3n+ACJJmMT6HeiZRdI4Vxz46WnC0X1fOY93uQDnKpOeBQYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jx52+7BxezvTZNvb5gtiWzX8yRdYsaGHElz07pmbuPM=;
 b=mVdXZ6kzSYkjy5BkHRp9n9r4LbVG3HsNP186vQfhuDF82NZ+NgEpQdLn8lzDYiWOT1S6dRgbwCT79RS94M6kmqkWdBj9yeGxbcPOd+46qBbwM4cxCGZDz3pVFgr4p2XQ95q7S2CbrdwtfudZyEqgBtICNCEyrsz3bjO3pecnANzudNP7FBfKLO4KOBDAh9FDAlUJKFLEkiVFl3oRp8W0xWR60g8jUQA/fKt6R/D7S5TH1jhhmtFLa+fJ9NWcEYOzAQuchE1YtCrxU4vdcLLWCbaJQ7vBZw17UgrN0IhP1lV697A9DOmBIbFeYGhTI/g7AtMh3Joeo5SarM2QmiT2wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB7809.namprd12.prod.outlook.com (2603:10b6:806:34e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 10:48:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 10:48:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Jun 2026 19:48:28 +0900
Message-Id: <DJDTG18HLIP8.Y2DDETB7V2L8@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 06/13] gpu: nova-core: fsp: move FMC firmware loading
 into wait_secure_boot
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-6-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-6-f2853e49ff7d@nvidia.com>
X-ClientProxiedBy: OS7P286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26d::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0eb815-703c-4251-cc86-08deceb978c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|376014|7416014|366016|4143699003|18002099003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7fLzPlKUGa1W1bSrkWkZ7zLgGkP15KLDFK0oQPUs387GkOwvW9DeQUxuXPblO8Udpu0KD5+py4xB0Io8yj7FfvKNPEg7xZXvFfY15Wi80GGy0t49c1APPPlR4ugYCjlANp6rYIDPzYV9w3afkDFdGohBoegI2AmnMYcAlqKZ3iFbcnhSrZg1RT4+1YlIniJJJrQkL7cJJMCZL1rnnQWIrrCwGntx1eK9vIxkidm2EUc5yIAKy1BLO7sFw0h6F7baZqBVBqFYkgERUr3v7dEVDf7rL7Bx8jojiAtO7p72wSpz1X0CPscIc8vqXUW/IYqgNgAmH5FMiqy106oe5kofv2vgpj92NTFTZG+EFioUvg4zz08bZsTUP+ZjPWQXD06JRHkmC2Mdr0fbe5wg3t4lKQa8Y+4w9EEq73/K1SiCsU5Z5I81CyBwEgVr7OxF3SqTV4sMkcajVMoADIHrYp6NZXoU3RRQTXRLwsNtM0fs/bctRbU+GpANCutC0ZHSUvml85Sto1ExnHYWSBh5IQJRTWrK22oYrspYci5h/iMo0gpafav+nPoqHn76JtpkXPDGSYC/sVuWCrTrsAz0FxF7LIs4JOYT0E1T5/xjWp9ob1UOsqiAnsCbERgNQVWanA9yg8jOJvshkY7zXn0NZGos3TUCvno9fyZgq3nkXHQjBK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(7416014)(366016)(4143699003)(18002099003)(11063799006)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1N6RlVYL0JmRzZmcHlxeDRxVmFVc01KYUFIMnVnSnE2Nndpd1BNSjdQc0ha?=
 =?utf-8?B?cEhvOVMzKzM5L0dvbTE1QUFCZUZrQWxaNlJVOGw1ZnRNTlNidUVqNHE3Qk1N?=
 =?utf-8?B?UVQ0OXlZeE1DbFVOeEozMGpvQUE5Umkwbm9jZzJpWW11ZEdGS2VybWNQMkRM?=
 =?utf-8?B?RURjT0lWR21DWWFIVmpIR2liQ1gwRVY3TWt4anNHTVk5SnFkamxHL2Vpd2M4?=
 =?utf-8?B?UXdTTmNRb2FqVnRiQTduSU80QTl4cjJxUGx6dFEvdHBMZDN6blU1cmxJV1Vt?=
 =?utf-8?B?S21QU0x5Q3ZhNkJ5UEZ4U3hxL01JUGZIL3p5c2ZvaVhkMjBaM0tSdkYzRUhL?=
 =?utf-8?B?akxXeW1CVW9ucFZUMGRURVJGYjJacVROaUxtL2l4b3NqcFhxUm1XbnIwQlgy?=
 =?utf-8?B?YWtIdkNZaGhaSUFRTjRYd0YzdWFoQys1N2FlVXNxb25lOStXZlFwbmhGejBK?=
 =?utf-8?B?enpHbWV2cmhHeTZkeEFmRmM3b2g2cGNMNUI3OHJhejJ3Z25WMGc4TXV2bGRD?=
 =?utf-8?B?VDM2N3NkZkFMUmZ1eFF1b1BKbXR1WFRTc3piKzlJd09ETmN1S3NINVQ0Qkdl?=
 =?utf-8?B?VWFjT2M1MDY5eVhqS25vK2dORTBDWkxRSjQwSWdXcU5aNUpxZlFWZGdCQ0VG?=
 =?utf-8?B?dE9pUVdtOS92NG0xTnRrbHphTmZwVGJHUEtjODF0Z0s0d1pxOWdqZ3MyaytW?=
 =?utf-8?B?VUVHUmw4TzNSWkNCelRyeHRGYzlCZWhuTlB4SnJ6QUszTVVVRVZKVmtmbGI0?=
 =?utf-8?B?YlhDckl0QXJsQUI4ZTRseGhZK01WdTdobkw2MFVab0gvY2QyMVBnQ28zUkhV?=
 =?utf-8?B?aGVlTEhuWjZoQjhLMTBiL0VvcE9Mc0dOYVNYUURYUGF5Szc3ajAvSjI0WkNM?=
 =?utf-8?B?K2ZWS2gxL2dNb2tPMldDY2ZuaEpqOWFXcFArSkI3WldXNGdYWGZxSkVTMmFh?=
 =?utf-8?B?RTVWY3VaSGdiL25rdERYdzBsQmlmS2YrZ0NPT01iMEFadVhlQVJTemFSbldr?=
 =?utf-8?B?MXhkTmczSStFRUE1bmlkL0duc3podnhmUzI1Z1lKWGk1OVU0L3pYaWlGYkR3?=
 =?utf-8?B?MHVXUGxYcGVGYkIzeE9YeS90bnh5L1l1c0JYT2ZJZWQ2TmRBYlM4TkpDQ0gz?=
 =?utf-8?B?dnN5eU1uY2FiZERvYldCdTFhL0hDMDRkdWNjNVE1QWJCRHlmcHlIN2hQQ3hN?=
 =?utf-8?B?TkJGL09ZeVhOY1Nwc0ViTEhWbzU5S1dzVjVhWGxqaElDWVR2ZkxhY2hUaTIr?=
 =?utf-8?B?aGF4aXFxUXViaXFWS1BycHdVTUVGOEJlUjE3YWhoVnlpb0FUMEpTZEJQVzRD?=
 =?utf-8?B?VzhZQ0FFbkpiN0YzbUJWYkNITWJzSHFSUE1lWGZlVWhPbG4zZ2kzVGdBdU1W?=
 =?utf-8?B?VDVRcGVxdUlFQ2RPZGtSdkVmQUdrcDZKWkpCYUNRNFIwNHFyUEN6MG52T0pi?=
 =?utf-8?B?ekVsdm5MSUhNRUtXZW5KMjlLbzZXeERPVFNDNk12a2Mxbm9yeTRvVUZieDZ0?=
 =?utf-8?B?eEgwbUpxKzVELzN2Y1ZuVWZnbXY5R3A1VXF5U1F1b2xTUGUvNzh6dERadkQw?=
 =?utf-8?B?NEVHYnlzSUlZQnVISEtDelBqZm9iaGlqUlJ5SjNWL01CaVJGZ2p5RmQxdFJH?=
 =?utf-8?B?Y0VaaE92ZzBXL2MxS0s3cEFTMG9pMGExTXZwUnVESFp4MTRqc3VPNFd2N0ll?=
 =?utf-8?B?bHhwbytqY2RoVlpOMlJPMnM0UHltTVJCMXBmMitIdUNFdFZ2UHkzSnpPV01w?=
 =?utf-8?B?SSswakVqZ05tbWJqd1F2Zm00K2VkWEJRQzhSQ3B0ODc4OUFxRlhYdGRFYVRW?=
 =?utf-8?B?WkdHaE40UEl0VitUY3pxcFVxV3lJUnB4S04vNWUzcmZFajZPMGR2M1hrVkVJ?=
 =?utf-8?B?WHZyWlc0UUZseEE5c3hBSlRaZmpEa2ZmSHlLYXBRWTF6RFRhNHdsMmhGNHBY?=
 =?utf-8?B?ZHQxUUZ6cnlkWXFPNmxpREVQekRIZXQ0ZnlmR1J5VXEzemErUWx1VUREeGJG?=
 =?utf-8?B?SUpkdlVvRjg0RGpwTWNucFZXWk5OT2swL2xiaCs2bFN4N1N1RURkZnBTRG11?=
 =?utf-8?B?aGxNU0thWElDUnlFNDQyK1NuZ3dvd2RIRDBSUUs2TWhnenc0UGZGMU9HV0pD?=
 =?utf-8?B?VVR5VEJCMFJFSVN5QTl2YWk3UTRBUW5Dd3d5ZWdNcFdDWVVWQk9xdktFL3VU?=
 =?utf-8?B?REtMTmN1QUsreFZidzFtalBYWmVIcCtUU3NlMnZrRUdLRVpWVGUxdkRJVjdy?=
 =?utf-8?B?SDhOQ2tybnR1akpNdVNqZVUrQW1mTUVVVmlsSTExNWxyY3hoYUJuVEhDTFQ1?=
 =?utf-8?B?Mk1UcmNGZ2dadG9pT0szaWNuTy8vOW1QNXQ0Z3FwWDBMZEtPK0MxUTZ1YmYy?=
 =?utf-8?Q?zDHgMOp9CQwVy+Nd0rEr+06Es1TyYbSqr9jJNv7+OJjKo?=
X-MS-Exchange-AntiSpam-MessageData-1: NPfQtpphjo7Vhg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0eb815-703c-4251-cc86-08deceb978c9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 10:48:32.5677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnTHqqYPxWR0nSggECIRzj4la7HMBr2gFnDg27qHGJRkBqqA/Vo64QVjHko9rltZHTtOo+A4YWoP1Ak+Sf2yfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7809
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

On Mon Jun 15, 2026 at 11:40 PM JST, Eliot Courtney wrote:
> `FspFirmware` is constructed and immediately passed into `Fsp`. It makes
> sense for `Fsp` to ask to load its firmware, so move it there.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Pushed to drm-rust-next, thanks!
