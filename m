Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D4A606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=t+TQw/gX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B053D112A35;
	Fri, 30 Oct 2026 21:43:05 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B11D210E8EA;
 Fri, 30 Oct 2026 21:42:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgnunH+43OwaE+EEcnAqwGyg0sVsyuSiZq33pfC3XMuWcFjd8uZsUxpHkVlh6MsPwVRufF43+YE4FEhMh1ydnNrI0ZoAk+wv2f4F7V4G/IW4WbCoKYzru52HO6SidPzpHOFLa/lgfa0G1Do3kEfjwH62H5prfmzixiN6IMZyJyjIf8wVfTt0vx37foLVh+TG8qDOcqeXDxiD+oKhQ0Raoi0tE3vOCxI5xE79G+OevxkBRCNqA4rav+nrFNW3gP7/nMO+bkyiFFzLqh6XGCGObXHJHrJNd+GT5u3YT5+75mKaMv3imjxmHtnzOmO+BJG63iEpEC8X3aYmQBOZcq22NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTeFvugFDiJ60oYoTUzNpXuYDG6bJesAlZuB9DDOJRk=;
 b=ALKFDHGSNAkU5oYeOX++c4nnZztQdegWuS5oGbOuwZ6U5CIDtIBzKOxIIGjvkBm0nlYRebwrV/SWzSqfZViTg3I8Hvty4xUfy9zc8jtRBHD87jo++2YXtycRC2Ky0xEe2foDTQqxI6gOHH/Vy0g1229CzEr0PdnDhunK8sBx2CmbKI3bgPad9YchH/DjgG4K/6b608UMaHrbDWaB0l+cDdmfdDCmG8pRpSl8+k/nBQ8zhHvlfZ5VCyvx3UgHqHHhZrdKvkI952GeDUSJsV7DIpik+B+FpiXivgc1wWmFj5U8ybo/3l769Pc19oBUaYVC8zNWuWpzwKMIDJsN7rwzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTeFvugFDiJ60oYoTUzNpXuYDG6bJesAlZuB9DDOJRk=;
 b=t+TQw/gXCIdozwqaNAAxv3w38ZLXsaQp8Lzsjs6Rz5cu5fjdGFe0RJ6110ENv5v48mYoEiSNSzosnKvu53t1c3C31z1qSDlj3kOsSKdM9roMMIqBzK2YietEee06OnIEEluPd3QcaA0o9qVMNSbq2sNWnpUBmvTBvMeH7cRqEvXFgdQxIKsIh4st64jJK2fW0RTKGU/6wy9LR1XoBiqrfGejI3HU3gAhE7jEyscJhib/5FqhA6aU0HKFPYWvq/2zxbDYt61g1/ZYLOIG9+TYIMJm5D849sKA4xl47ZjM1vMDAqV+nw0rAbCI1M2qOMh3Sl18EjVyQ98tRjHk6Vzd7g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 21:42:54 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 21:42:54 +0000
Message-ID: <1791cdd4-02b0-4c98-870e-8377237afe6a@nvidia.com>
Date: Fri, 30 Oct 2026 14:42:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu: nova-core: make pramin/buddy optional
To: Alexandre Courbot <acourbot@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>
Cc: airlied@redhat.com, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
References: <20261026-nova-pramin-option-v1-1-d073b3f047fc@redhat.com>
 <DMI0H1ZU5R4C.25MM4QF6UDWA2@nvidia.com>
 <DMI4UK02HZB8.1KEPETWUOZ7E5@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DMI4UK02HZB8.1KEPETWUOZ7E5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a03:505::25) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5239f0-87ef-4366-93b0-08df36cec15d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|11063799006|4143699003|56012099006|261028144727099003|261026121527099003|261022105027099003|261026140227099003|261021121427099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: DEC9DB4AhzcjqKnwG35tIzzDRuJiE8kECGyWTzxPZBMtx4RP6gbK/wX3U27j7oAGFpboXj8OIefOUyZYDrs75q93c5GusR8EZbCUexoOO7CSKi3m45cTH92+FVEZ2KH2etNV0PZzUDPA5tS86/bHhch2fa1vFtnJvMB2+y6wzhpRAjovV8T3U8gW2221PwxkgwKmA6fngF2oHTpbIn1z50GCOVBt130c9p66DJjpAEwP4XjrfvexoNfdJL581L7FWuB/jHmLjuQAe9DPA8qf33bdHSf0dvrU33ylZibtoCoCOjjvSfpY10+fCB5mn8LeFLXvnMheo0203TXJfUfcnKHbdvEZeNqqZBagw8tUyjGMQCejyHTcGpQZfuZUhbJIu94R6lKAit70qyUFJLBFfeY3+EG7xctWCqMTOa4PkWBL+gkjIqCk/EwwES+YrwJxnhChaVS27XtbmY996hYizxPYRhW+QmgJZeiItRQpmNkJTNALG8XD9ZS+vUkdsF3OQGK19MR5tNmj7ooyzlb+4zdBlYkRa7STWJqSDTC3brjumuvPKBZBDnKYVXxMz6vtmt96MI15YZir1z7RiVC9kzdWc/SYab422vQcuQ2GzYPfjlhxxF/WVBq/XuHk8ChWOOi6A8x3EPqY1dByRgzslBiyAbkQUiukPalK39+kWv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB5614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(56012099006)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261021121427099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2NNUjZrREtEZS9DV1ZIbVV2OHl4RTlDSnZ5c2huc3VIa2NiNE1ZVUlzNXoz?=
 =?utf-8?B?U0xqVHZnMVFBbWxNaFhtY3VMbWVpN0ppdVpRYjBHVnJpMENtaDJGWE1TQkhG?=
 =?utf-8?B?N01hWnJvQ1JGWTh3RTVxYTRUV3RMQ1JaT2JQd0ROei91bjhnRG5rTEs0cjRz?=
 =?utf-8?B?cGJieEl5ZmpaSXV1c3p3NXRQNkhldlllNGk5NDNRZjY3QnpsajlHb21KM2pD?=
 =?utf-8?B?Z3V2VTZjaHFMbzV0SERaa24rOVFZWW04Y05UNXNGRldlVitLbjhPVjFtNjNX?=
 =?utf-8?B?cFg1U3RCTGNNRldDUVJ5bVlIdXNYMlpVRER3SUFMc09HMEgxdGVidXJvZ05L?=
 =?utf-8?B?b2NkWDMwNWJ1ejB0YXhyRWsxZGJrTHdQMFFXOXh4OEV1VVZSSzN4cHVHcFg4?=
 =?utf-8?B?RjlsZE5xODhSRzliK3B5YlFXb2xwWTVIRWtramJJNi9pRTM0cU5iSnFWWWMr?=
 =?utf-8?B?WWd1YzRnRXdCYkpYb05TT0ZpNyszQ1o4dllUMkREaTNUQkhVcDdwUHByaXkw?=
 =?utf-8?B?d29PUmp1bERyYjRNK3hZYVZ4SGF3TVB6ZHRRbDhMa0NSMnU0endJRXcwN0xw?=
 =?utf-8?B?QmdJby85ZnBkMmFIRW1lV0ZTQlJuVGcxRGZiMjczQlpJdzVsSHcyaTRjY3c3?=
 =?utf-8?B?djUySkpkVkxQUE5MemExR041eHpiS0JNSGI3cElkbnI2UzF4emFlUzMxKzJO?=
 =?utf-8?B?VEQ2QVZ3RjZycHVoeWtQdzg5VkRETnE1TjNTZnlNVFVmbG82a2RsREpVdmQx?=
 =?utf-8?B?VmxvNGc2VVJSTkNTcndTK2doV2dnTk1rUDhyWFZpUGZkLy83RjBoemc5YmZs?=
 =?utf-8?B?ck1udk4wOEhweGNoaUkyZ1RqMmtxd3oxa1pkclI3MXRxRkxVeVQ3STRkR3ZG?=
 =?utf-8?B?bmRycStYa0VUN2k1M3hnaGtPZ3NlcGYvKzg5YzR1NEh3S2lPaklNK2doOVFj?=
 =?utf-8?B?RzRVMGQ0aGZmRXFZOHluVFlCTmR3QkMvQkVZTXAxaGdiVVlNaXpLdVpaU01R?=
 =?utf-8?B?aWlmejAyek4vaTVqeTIrZnkrMTRqeUtqVGI2WXBiSmVkaUx0dk1QYUQ4dnMy?=
 =?utf-8?B?U28rb3RuL0oyUXJiZitEQk43U3JCNXR0S2RFTnlYYVplZFdyMzJmQUVCT2c3?=
 =?utf-8?B?K2g3aVNoa0xNUldhWmZobkV3MTRlSUZPdk5QZmY1WHppbWhjTzk0bm5HYzNs?=
 =?utf-8?B?aFdYbUU4bWl4TWVta3B5NVlXNVNTdGF2OUNGNHAxQ1Q0OTV0V0hsTU5VNzI1?=
 =?utf-8?B?YllWWlg4ZFh4WjRkSlFiTkZEcUlrTjl0amduZk00WEZ2UEovOE11ZkF1Y3RC?=
 =?utf-8?B?d085WDRzV1k3d3QwNHFNVHVYZ0FEaDFhM1I1NHZHeGRHYnM1dTErSVJDOWNy?=
 =?utf-8?B?VDU3RTlXdHF3NHNNdHd2bzBCanplYkhlQTh3bVlDTnErQWJWQi9EUUZWNHdr?=
 =?utf-8?B?citTeXJHU2dzVFdublh3aUpnMmM0dmgrZ3NOT2hucmRJallUb28yWTFJZU84?=
 =?utf-8?B?dklidzRWVVFnVHRXWkQzRXVvd2x4Nm1kWkNJN3VWZ3BmMG1FS0RTSzdDYlpv?=
 =?utf-8?B?THB2TS9KYlRBbGtTdkdKR01FWlh4RW4xSFZxc245cnF0S3VNU3UyTDlBOEw0?=
 =?utf-8?B?aTJ6WE04YndjRURZeGs0enkwZ3VLeDFDUTNRcXpEMTliMThhVm4yU0VQdXdq?=
 =?utf-8?B?S3VITjlGVEQxTFJ2V1NYQ1ErRmdXL0hodFpRQ0xGN2RobkwyTy9oK0tmemZN?=
 =?utf-8?B?TU1HcUFwVUEvVHV3MWtPTUdHZlV4ZXRGNWpYVUxNV0dwSm55OFdmcTBoWTJv?=
 =?utf-8?B?WXhKUVpoUTd1bTVnZnhhaEFBLy9YVkRTVDlzajB5b3plbk95MWZyVW83NG92?=
 =?utf-8?B?MU5xVXZUa1IwQzN1bE44bEVNcm5uNWxKcEwvTXdPMXFXRTN5SmNBRTdMWENz?=
 =?utf-8?B?OWFvNmtMNURnUnhxYUdPcGt6U1hDOThuQml1NVFvN0JjMlh0bmQvOFpsSjY0?=
 =?utf-8?B?ai9SVi91SlZrekxZa3l5a0tCdUluN09ZMEpKV0wwc21oa1VvcUZLNVZyYzJL?=
 =?utf-8?B?dFljMXBFcGtTeEtOOVhpVlduQS9MMlcvdTVZeXYyeUNJeE5NZEdyMVVCelpF?=
 =?utf-8?B?c3hzaDRBalFwZXN1cWh0RFhFNHVIYWhzTlAxdmQwczZjeVJDU0ZWbndqb2xZ?=
 =?utf-8?B?SnMxY212a2R2L1luL3BUVHRQTnhjdVNyUHM1SEZsTXYvWDhFZzU4YVFxZFpm?=
 =?utf-8?B?bWJ2QStOVG9QdXdUUWxndDg0bDZVQzRnVkFGd1JaczdsYWxhRm1wYkFISklF?=
 =?utf-8?B?QlIwalBOMWtheHNEZHRQdHNpVzhzVTU1NlVXTlpyL3RTL1V5WThCUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5239f0-87ef-4366-93b0-08df36cec15d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 21:42:54.6475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/mqLf3UmiER65dhel2JjZHkruD/mVeJ+y7iJpiMbWKiwsPtHnNU8UTVDuLzd649acHubeGs/3F0XA6PKE11mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 4:23 AM, Alexandre Courbot wrote:
> On Fri Oct 30, 2026 at 4:57 PM JST, Eliot Courtney wrote:
>> On Mon Oct 26, 2026 at 1:24 PM JST, Dave Airlie via B4 Relay wrote:
>>> From: Dave Airlie <airlied@redhat.com>
...
> Typically "a helper method on Chipset" means that we want a HAL method.
> It just so happens that we already have a FB HAL, and a `vidmem_size`
> method on it. I don't know if a vidmem size of `0` can always be
> interpreted as "no framebuffer", but if not maybe we can rework it to
> add that information, or just add a new method.

Open RM never infers zero FB from a size. The FB sizes that it reports
are 0 because "bGpuArchIsZeroFb" is set, and it does not read the FB
size registers to decide.


thanks,
-- 
John Hubbard

