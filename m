Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212AB606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5Vx50p7m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB411125D7;
	Thu, 22 Oct 2026 12:51:15 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8801125D6;
 Thu, 22 Oct 2026 12:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+ePP62zBNhockumMd1XWAT0zLpEsjK4PvJNsjKimDizuwVprg5oiHH+qOs1CkJZSBawkIEFZa2hL4RKanKCp1/phy2xy9q+kNyk/OvOckJRa4hk+TBsIHQtHBULR9dO6J2qokFPIGoYIJxxP57T4Vdue3LxFXx7ipptfJMqJ56Yt46qfUyk4iOu9hKZfJFUJBif57WcE00jUz9qSg3J0emqw/povaRUcOwEFG19w/gMcik22SsQJCZWtZeUVzZ+D5IYNONWbjH0+3jg0Xs7Z1P+mnt7SlkTEKr46a6wU3kqNm4VduT6KYLxjJYnrHktFVUWKIMEdfACrLzHNaY1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMIeIFQVr+6ftq8D6oQLq1Al0V8jYJmLLkeJLqduiAQ=;
 b=ej9z1CJfsseVCeNDJPCZnNZILcLiZ/LyddGzmamctQQUKVGfgKgCgaJ7/J9Qa6SJA+ObMcxKPIxo40LZ9cNgFinLXcwbwe7nugH/3T2zF3/uE7ewV0j+bJ4Iu1bjJIDkx6IAaWGmHzhxLDZXnF9u8wS654+GhAM7AP/WNawH5ETjLfKdy8Gpz5JcmsIdL8KyMFswJVjlhj+l//83BljoreResi7ddBSqyEY/96oH+3FKqMsMjjpC8B4AVgnukvbOG73/cqU1E0q3TiGqz4KAL5HM5iTnSfij2G2btUh/jv9zN9kZS6JFdm/d8TycJHQgGLCKHGJyUkLZTCaOM8Hl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMIeIFQVr+6ftq8D6oQLq1Al0V8jYJmLLkeJLqduiAQ=;
 b=5Vx50p7mwJXwjC+QPn5bKWKwEb5uhguSaJypMgafCLtbtQoL+omRV8t9PE6qQ0eZxH97th/c8MI9/QjGCpqNOhB9xEMXhpDODmS/hE7VMeYesypGHWQks36bV2qq+VDq/HKPViATrhW7+VayaXAYui3rNVPL4rWFjn0ARpnWOTQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 12:51:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 12:51:04 +0000
Message-ID: <a2f06480-786c-4189-8984-7cf3fd7a81ab@amd.com>
Date: Thu, 22 Oct 2026 14:50:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/radeon: retry UVD v1 init on failure after resume
To: =?UTF-8?B?0J4g0Jo=?= <kolomiiec@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, Leo Liu <leo.liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 dri-devel@lists.freedesktop.org
References: <20261019144916.108589-1-kolomiiec@gmail.com>
 <CADnq5_Nabpz1U+taZX7-Adc+ZtCKCvyPsz7etBYkewpnRpgC+g@mail.gmail.com>
 <dbaf07c4-9d14-41a1-a943-0ce5e9c7eff8@amd.com>
 <CA+e2gLu+tUWXgQ5F08W9L8FY3K12bMQKPAqaPdzb14NxKVdOFA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CA+e2gLu+tUWXgQ5F08W9L8FY3K12bMQKPAqaPdzb14NxKVdOFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c24f04c-2f6c-4637-238b-08df303b2248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|22082099003|10067099003|18002099003|261021121427099003|3023799007|261021123027099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: vVuvu+2J209xFZdREjoeyPe34/y3H5A0X/rrhv2NimCZEDhHKPGr1Fss4MUvicHN5zybQFR96ouFmyYKW4JI0pFm1DFvkSH5Ey7e0tp+yxAPrj52yLkA/6fhREAWFtohwx4WT0YWKl3Ofw/igfrkIH5yxMmRzyC10i6c3f86Oqkzl9iv8mdc/baSqc81JeWMtGyEohBrxVzHsZOIPvbFhy9EsTwIK/BwHl974KlJNZeCPo3H7g8StgG1b4Ww9JtBLn+QcI53GIFLtrIvTxuas6pLPOoI3XOdEc2P2M+glQWQB7jxir72jlPC2sVTSoiFQQgZ9Gbja0dEFSApyWUA/blDOSuiL50t6juE70u96qEQgLKyRufr2Y6ZnebRluk8hwzIlGz2QpUoBRdxB4OBHhDamUthjQMGG/V8V42V0ElLYFqV6PV75TCNOGXAuKknQth2pOdBD3gIShMxmySwiUqsuOHL6zOLweo8Wp/+/kS8F9Y3yh1KhDmbXJmsX5UKWkDGcv8cj7KzGlOmHp829nIRWNrmXvTiDsqlL5Va6l6C0KWewDMlsIpClm5wnr4uAC4x5b4eJqvH3Fx3s3dU3716vMyMg8/E7iUIebg+eeA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(10067099003)(18002099003)(261021121427099003)(3023799007)(261021123027099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amVmQkd5RHk5YWdTelBUOFQ0NzI0QU5jSXZHVm5mQlJiRm1VMjJvNEpsN2Vl?=
 =?utf-8?B?dlN5d3VnMUFvTVNxcmVlMXNYQy9xbERTakt6M0ZiQlFVL2VTT3JoeUJQRlhC?=
 =?utf-8?B?bEp1cW9SbzVpZGhCT0dxWW5tVlB4Q3RibzZkUDFnY0ZyYlc5eGcvRTNFNXRy?=
 =?utf-8?B?dEQwVVhZMnl1NFFqZzVYdG5UR01DRTdyOWkwK1V5djRtVk51dXZrQm5SL3N2?=
 =?utf-8?B?VXdJamRmOXZlclZkQzdtTGJkdGxNNTlwRUhDeFNyRWdsTW1BQkVvVDNKdXY4?=
 =?utf-8?B?N0VHWGl6THJRNHRWNFV2T0MvaWllZWFab3l0S29PMFphOTlzeVhJZ0Z5MFUr?=
 =?utf-8?B?WmFFREVWcTJud3BBclZXL1kxUjl4eWJDN0c5RGx6UFk3YmVETlNvSDdGR2x6?=
 =?utf-8?B?Y2J0YUVEN2E3MU1tbHgwMFlCMWhwTzZuT3lTbmkxZkl5TTYwZlFxemFoVlpr?=
 =?utf-8?B?eCtJTlNSUHNMd2QzUStkazQ0MGc1MkJhTktmN1ByQkRKTkdjaFluZXlxbmw0?=
 =?utf-8?B?eTB3MkU0TWU0SjdOSStXT0VyYmthcDlUbU5oM3dOM0wvbUVDelo2cUg2K2lF?=
 =?utf-8?B?QVF1RlJxWmdtT056akpYWXVnVUtYdzE3WkZUL3UyT2swSTRFRVlwY2g1QVFk?=
 =?utf-8?B?dHU5cWZVNDl6cFhwdzlZbEI4Z1FueVJqKzFrWlY4bFlkZ2lnQWhITXpwUHZM?=
 =?utf-8?B?Rk9HOTlyVzd6YzdzUTlXQUhWamw0eS9QSjZnQXB3ZDJZdzBTZzN5TFE3aFU4?=
 =?utf-8?B?MVRoOGhROG5ybnNLSDg2LzJHdWIxekpPZ2VsUUdSM20zQzFHTHFrMEc4MkZO?=
 =?utf-8?B?V0VDb0RpRHpPMGkzb2ZRK1VFY0tIeXIxUkNiaDJLOGZ6b1JTaTUzelN2SEZq?=
 =?utf-8?B?ellhYU42aFVwNEhlYkc3OUUrTk5QTUo2QzRqTGUzRWhTZmNuZVBEZUswdWUw?=
 =?utf-8?B?R2RLdmREWHpndjZzQmoxZll5MDJOT3Q1aDM0TVVDUlk4VThzU3Q1TWZiekM2?=
 =?utf-8?B?b0dPQ1VzaDMxbW9rbUR5eFhreDlpYnVnOUYzQUhCbDRldVJjalJuYzJNQWta?=
 =?utf-8?B?MEtSNkIzQ3YrRUdiYU1BcUwyZi9ZTStneTFYRjdiellWY2c5N2ZqbC8walc0?=
 =?utf-8?B?YmFJa3hpdjJtSzM1T1B6QnFUUTlGZW9VRi92elIvYXovQ29jWDN3R2FvUHZD?=
 =?utf-8?B?K09weTZXM2xDZitrb25GalpaSk1SaTF4bCtUMFlzcFNFS09jSXN0R0xDZUwv?=
 =?utf-8?B?bFFUUzRCUklteU83U1ZGditySGE3OFRqUFRwSUR6bStMcGZQbFBkZ1Rvdmsv?=
 =?utf-8?B?UVN1TUlOaXR2Y2plVm92eTNaSTVuUmd2RVJwcFZOa1VPSGZkREdiSjhEc1Bq?=
 =?utf-8?B?Ris0ZlVWdHZBeVhZZzNYYkpQQTh0SG5WVmM5SlpvWkFKZUkrQy9vODBYclRR?=
 =?utf-8?B?S3RFZUc0L0tiVis4cUlpcjRuN2JYekRuZW1aeWtTZmhvZ0RkTXBEWEdkcnI3?=
 =?utf-8?B?UXRydGxiZFVXN0V2eXdqazdmWTJsbFpRVVdydDI0NTF0Zml6WTRST0tPRmRq?=
 =?utf-8?B?WE1jSDZWZHlZT1JhSW1SR1QyN2FVS1Q0SkVTNnpUSkdFSFgwK2FPa3F2M2d3?=
 =?utf-8?B?WlpQMXpySFg2RWU1enp4ZEV4Z2RZaFFNMnRRMVhuR0ZXSTZZYzY3V2NLZHpH?=
 =?utf-8?B?Z0hsZGJDYkR5Zndrazd1R1Rsd2JFeVFrV1A3clgvM1hwTlJuSXdCc2h5ZS9k?=
 =?utf-8?B?K1RHMUFmblBiYnR6NEFpUmpVSkNvRU1TSEhYNEZWc1pwdmMrZ0tqbmF3Y2ZL?=
 =?utf-8?B?bnFMRXN3NzVyZmZteWVjVHNSbDd5cnNPYXBWQU1vWDhpYmN2SFc2UWxjTlRB?=
 =?utf-8?B?YmVnWDVVNVpFRjJJMTBBVUNQSG9xWXQ5SWJycjNqSGs3TGV3NUdQWWFKZWpu?=
 =?utf-8?B?cUpWZUJDTTdIbWJ0bXc4UFZlUTRsZXZ1NWpwdGVRTVpDY0htd0poS2xjSk8w?=
 =?utf-8?B?ODNKMEJGK2tiK3g2aXhWVlFsMlg2dk03VFRMM1YyY09MbHk4QlZoZ2tIWGpX?=
 =?utf-8?B?aWQrRXVrQ2tXbTc1emVHc3BCSHk3dG9yWkQ3RDlVNjNMZUVaZDhTOXgyTTdO?=
 =?utf-8?B?MHhVNlFNZFhVSkoyQk1LeXRUVCtQa1krYVBmRzd6MGtUQ28xL25VaFI5eEt1?=
 =?utf-8?B?UTgzT2xxd0xFTUsyQ0VhdWh5RTNLeWRvMGgrK0o0MS9PZy9OUWJHVm1HbUdL?=
 =?utf-8?B?OHVQY2w4WmlpNFhWb3JWOG9CZ1NwSG5pSFl6aTJEMnRzWGU4c09paGtRVlNa?=
 =?utf-8?Q?xQIBVrNUHJlty9Mr2J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c24f04c-2f6c-4637-238b-08df303b2248
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:51:04.7711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yalZyEwSoGxcx0wyxrECdWAJBD0sum7HTOsaRq9aee3INAdKvWY/Uo5NAe0oC7kB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 23:47, О К wrote:
> Hello everybody,
> 
>> That HW is ancient!
> 
> It is — and still in daily service here, which is exactly why I care. :)
> 
>> The question is really if that works reliable or if that could break anything?
> 
> Fair frame, so let me answer it directly.
> 
> 1) The success path is bit-identical to stock. When the first attempt
> works (cold boot, healthy resumes), the added code executes zero extra
> instructions — the loop breaks immediately.
> 
> 2) The failure path cannot leave the system worse than stock.
Oh well, that is not even remotely true :)

The problem is that those old HW generations work with a rather rudimentary UVD FW signing. When that FW signing HW block thinks you are tampering with the UVD FW the device usually spontaneously falls of the bus.

In other words you can't read/write the PCI config space of the device any more, reads to MMIO BARs only return 0xffffffff and a few seconds later the system becomes completely unresponsive and you can only power cycle it to get out of that.

> Today a
> failed ring test already ends in -EINVAL with UVD dead for the session.
> The patch only adds up to two more bounded attempts (~250 ms each:
> start, ring test, stop, 20 ms settle) and then falls through to the
> same failure state. The display rings (0/3) and the rest of the resume
> path never touch this code — and years of stock behavior prove the
> machine resumes fine with UVD dead.

Yeah that sounds unproblematic, the bit extra delay is not really a problem.

> 3) The one real hazard — MMIO to an unclocked UVD block in the retry's
> stop path — was caught by the Sashiko review and is fixed in the
> [PATCH v3] already on the list: stop is now called only when clock
> setup succeeded. v3 also drops the warm-up cycle and the widened poll
> window I had in v2 — both reviews were right that they didn't belong;
> our measurements agree (neither prevented first-attempt failures).

Yeah that is definitely a good idea as well.

IIRC there is also a bit in the LMI register which is called *_VPU_STALL_* or something like that. Setting that before a retry and waiting a few miliseconds is usually a good idea as well.

> Measured on the target machine (HD 5650M, kernel 7.0.0): stock survives
> resume with working UVD in ~50% of 42 measured cycles; patched has been
> 12/12 on the test stand plus every daily resume since.
> 
> If you prefer a tighter bound, I'm fine with 2 attempts instead of 3.

That is not really the problem, question is rather have you seen any hard crashes with this?

Regards,
Christian.

> 
>> when resume doesn't work at all any more then that would be really bad
> 
> Agreed — and that scenario is exactly what the v3 guard is about.
> 
> Thanks,
> Oleg
> 
> ср, 21 жовт. 2026 р. о 17:28 Christian König <christian.koenig@amd.com> пише:
>>
>> That HW is ancient!
>>
>> The question is really if that works reliable or if that could break anything?
>>
>> I mean when UVD doesn't work after resume is ugly, but when resume doesn't work at all any more then that would be really bad.
>>
>> Regards,
>> Christian.
>>
>> On 10/21/26 15:29, Alex Deucher wrote:
>>> + Leo, Christian
>>>
>>> On Tue, Oct 20, 2026 at 3:46 AM ukrainer8 <kolomiiec@gmail.com> wrote:
>>>>
>>>> On Evergreen/Redwood (and likely other UVD v1/v2 hardware), resume from
>>>> suspend intermittently fails the UVD ring test:
>>>>
>>>>     radeon 0000:01:00.0: [drm] *ERROR* radeon: ring 5 test failed (0xCAFEDEAD)
>>>>     radeon 0000:01:00.0: failed initializing UVD (-22).
>>>>
>>>> Cold boot always succeeds; resume succeeds only in about half of the cycles
>>>> (42 measured suspend/resume cycles on a Radeon HD 5650M: OK counts per
>>>> 6-cycle run were 2, 3, 5, 6, 1, 5, 3). Once the ring test fails, UVD stays
>>>> dead for the rest of the session and hardware video decode silently falls
>>>> back to CPU.
>>>>
>>>> The resume path runs the same full asic startup as cold boot
>>>> (evergreen_resume() -> evergreen_startup()), so the difference is the
>>>> hardware state at entry, not a skipped call. Field data shows the first
>>>> ring instance after resume is dead functionally, not by timeout: the ring
>>>> test fails fast and deterministically, and only a full stop+init cycle
>>>> revives the engine.
>>>>
>>>> Fix this the way the Windows driver effectively does it: silently cycle
>>>> the engine once (clocks up, start, stop, 20 ms settle) before testing,
>>>> then run the init sequence in a retry loop - on failure of clock setup,
>>>> VCPU start or the ring test, fully stop UVD, let it settle for 20 ms and
>>>> try again (up to 3 attempts). Each retry logs the failing step and the
>>>> attempt number, which also makes future reports of this failure mode
>>>> self-diagnosing. The ring-test polling window is widened from 100 ms to
>>>> 2000 ms as spare capacity; the early-exit poll keeps healthy hardware on
>>>> the fast path.
>>>>
>>>> On the same machine the patched driver went 6/6 OK across repeated test
>>>> runs, with the warm-up absorbing the dead first instance and zero error
>>>> lines in dmesg.
>>>>
>>>> v2: guard uvd_v1_0_stop() behind successful clock setup, per Sashiko AI
>>>> review - MMIO writes to an unclocked UVD block can cause a PCI bus master
>>>> abort and hard-hang the system.
>>>>
>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
>>>> Link: https://bugs.launchpad.net/bugs/1865130
>>>> Tested-by: ukrainer8 <kolomiiec@gmail.com>   # Radeon HD 5650M, kernel 7.0.0
>>>> Signed-off-by: ukrainer8 <kolomiiec@gmail.com>
>>>> ---
>>>> v1 -> v2: keep the clock-setup result in a separate variable and only
>>>> call uvd_v1_0_stop() when clocks were actually raised (Sashiko AI review).
>>>> Also folded in the silent warm-up cycle and the wider ring-test window
>>>> validated in field testing since v1.
>>>>  drivers/gpu/drm/radeon/uvd_v1_0.c | 57 ++++++++++++++++++++++++++-------------
>>>> --- a/drivers/gpu/drm/radeon/uvd_v1_0.c
>>>> +++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
>>>> @@ -158,24 +158,58 @@
>>>>  {
>>>>         struct radeon_ring *ring = &rdev->ring[R600_RING_TYPE_UVD_INDEX];
>>>>         uint32_t tmp;
>>>> -       int r;
>>>> +       int r, retry, clk_err;
>>>>
>>>> -       /* raise clocks while booting up the VCPU */
>>>> +       /* warm-up: silently cycle the engine once (like the Windows driver),
>>>> +        * the first ring instance after resume is dead functionally */
>>>>         if (rdev->family < CHIP_RV740)
>>>>                 radeon_set_uvd_clocks(rdev, 10000, 10000);
>>>>         else
>>>>                 radeon_set_uvd_clocks(rdev, 53300, 40000);
>>>> +       uvd_v1_0_start(rdev);
>>>> +       uvd_v1_0_stop(rdev);
>>>> +       mdelay(20);
>>>>
>>>> -       r = uvd_v1_0_start(rdev);
>>>> -       if (r)
>>>> -               goto done;
>>>> +       /* after resume the first ring test can race with the hardware; retry */
>>>> +       for (retry = 0; retry < 3; retry++) {
>>>> +               /* raise clocks while booting up the VCPU */
>>>> +               if (rdev->family < CHIP_RV740)
>>>> +                       clk_err = radeon_set_uvd_clocks(rdev, 10000, 10000);
>>>> +               else
>>>> +                       clk_err = radeon_set_uvd_clocks(rdev, 53300, 40000);
>>>> +               r = clk_err;
>>>> +               if (r)
>>>> +                       drm_warn(&rdev->ddev, "radeon: raising UVD clocks failed (%d), attempt %d\n",
>>>> +                                r, retry + 1);
>>>> +
>>>> +               if (!r) {
>>>> +                       r = uvd_v1_0_start(rdev);
>>>> +                       if (r)
>>>> +                               drm_warn(&rdev->ddev, "radeon: starting UVD failed (%d), attempt %d\n",
>>>> +                                        r, retry + 1);
>>>> +               }
>>>>
>>>> -       ring->ready = true;
>>>> -       r = radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
>>>> -       if (r) {
>>>> -               ring->ready = false;
>>>> -               goto done;
>>>> +               if (!r) {
>>>> +                       ring->ready = true;
>>>> +                       r = radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
>>>> +                       if (r) {
>>>> +                               ring->ready = false;
>>>> +                               drm_warn(&rdev->ddev, "radeon: UVD ring test failed (%d), attempt %d\n",
>>>> +                                        r, retry + 1);
>>>> +                       }
>>>> +               }
>>>> +
>>>> +               if (!r)
>>>> +                       break;
>>>> +
>>>> +               /* MMIO is only safe when the block is actually clocked */
>>>> +               if (!clk_err)
>>>> +                       uvd_v1_0_stop(rdev);
>>>> +               if (retry < 2)
>>>> +                       mdelay(20);
>>>>         }
>>>> +       if (r)
>>>> +               goto done;
>>>>
>>>>         r = radeon_ring_lock(rdev, ring, 10);
>>>>         if (r) {
>>>> @@ -421,7 +455,8 @@
>>>>  int uvd_v1_0_ring_test(struct radeon_device *rdev, struct radeon_ring *ring)
>>>>  {
>>>>         uint32_t tmp = 0;
>>>> -       unsigned i;
>>>> +       /* after resume the ring buffer controller needs ~1.5-2s to settle */
>>>> +       unsigned i, timeout = 2000000;
>>>>         int r;
>>>>
>>>>         WREG32(UVD_CONTEXT_ID, 0xCAFEDEAD);
>>>> @@ -434,14 +469,14 @@
>>>>         radeon_ring_write(ring, PACKET0(UVD_CONTEXT_ID, 0));
>>>>         radeon_ring_write(ring, 0xDEADBEEF);
>>>>         radeon_ring_unlock_commit(rdev, ring, false);
>>>> -       for (i = 0; i < rdev->usec_timeout; i++) {
>>>> +       for (i = 0; i < timeout; i++) {
>>>>                 tmp = RREG32(UVD_CONTEXT_ID);
>>>>                 if (tmp == 0xDEADBEEF)
>>>>                         break;
>>>>                 udelay(1);
>>>>         }
>>>>
>>>> -       if (i < rdev->usec_timeout) {
>>>> +       if (i < timeout) {
>>>>                 drm_info(&rdev->ddev, "ring test on %d succeeded in %d usecs\n",
>>>>                          ring->idx, i);
>>>>         } else {
>>

