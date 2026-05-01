Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F48FF8864
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 05:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7746910E05E;
	Fri,  1 May 2026 05:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lwANVKK1";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012047.outbound.protection.outlook.com
 [40.93.195.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE3FC10E05E
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 05:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvyWPI9sNadVX2OcdAzkRAwXA5yWRnALRqMbNrnrmRcRcRHNG7rhURoTuaoTRqB3UCA70ff73iBPjsOjYZ1IxaxnHWM7F0m/EKiiqh/uDq8EJcNKbjvVcAEF4xq+7YUMW5L3ZPIEbIsXYPY0Ln4wiax1DuaEyYahC1Ys/vfjHhE8qA2B/CooOz8YA4QxvhZ0oNLdUqIHJ9QZohx77wFIP+i8vaPqNKaHAFVqSnfuJI4yRegVe4SKC4fdcAoblw/p5VAPAOUrWBRR5b3qemZkDZK0CuR1087DluUJkAeNbLawNFMr0dq+gvmsAzZ1ibbid+TV523VxjPasYHgzT6y7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RGORqYNtd2Zg0Cq/oQtbdV+VcgR1pDWfgZXWxShcBc=;
 b=F2alLnF5ZSKWV+8lN3zVwTw773+DHAgypdt/r0T8xmrRBo0lb31HaGY9mrny9XDMnrMir8mD+eulqZhAc2inW+VgnSSSHlVpdRO9/PdSy2hszFzUdD38qAYYCRf7Dw7+fo8ZJv02L7GFRnly5fa/7vg95yWQlEtCw+T//V8KmiVQYEwXA2DZdz9lGSd/eBgZe7WN3wnc+JF3tHh5TKqNuYk5+OlnMAJNx/hWQL+mo7a6w88TKJjs4Ae46/8rSKPcMS8GTkKZvzQvwyC1b/0DDVUcIKCIfy5KXzKSp93tWQmT+kAPB1fpKTB1XF6JTcdYnDKc3XODRbSh8rfaVLOEvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RGORqYNtd2Zg0Cq/oQtbdV+VcgR1pDWfgZXWxShcBc=;
 b=lwANVKK1gjXc9IBhEgepv5/SFeykn9PqFCdSRtkp9hfg4s0HilhEg/Bum3KOzr6dXIW10lltDPdEO6lsjNJgPHRFnpngW3bPC2vql0oe3/jTx+bQnXGTWReMj+Xn4k4D0ae160Yj3pUB4nJlROupF4mOZTOeNFW3sVfUKCw9/mEmhR9mlZ9BDht89ZKxFj8OeJHJEKJyHH5oBj4eVlQYA/VJu5UVuB0hj5PeWK63Q2n4upr95CUDRcRzsLOhS0Fwiu22Kyd+P4wWEzXRPzWFU1PU50xwJwMrMdZ8efsHRXZ22i9m3uitLQWMXW/DTjsDbspt5r5p75KLI6PAIQNxOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Fri, 1 May
 2026 05:38:30 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 05:38:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 14:38:26 +0900
Message-Id: <DI73JF6TH5V3.13J70N2SRI5E3@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Fernandes" <joelagnelf@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/11] gpu: nova-core: vbios: limit `BitToken` entry
 reads
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
 <20260421-fix-vbios-v3-2-8f648aef7a85@nvidia.com>
 <DI5OFKEERXGP.1EFM9XNWQQ1YA@nvidia.com>
In-Reply-To: <DI5OFKEERXGP.1EFM9XNWQQ1YA@nvidia.com>
X-ClientProxiedBy: TY4P301CA0115.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: de56228f-fd35-4c79-b450-08dea743e073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: BEKPTw53//NIKe+8d56JNa6GNzi1KLPE0OQKjrIevKIztwiFztQJU7sUIR5mBa2u5BtqvK/nI6Zk7ibgfnU5LgTkn9NEIc4mNnNYraE8pi4FK4lvIax2Yku78M74VK8fdnmBuiKlA0yAeJZZQU8Ddj2PJb6HZPv2+s13gpmfuXnAWOYx+UvhvPfcNrKQFhgzJHHmRH5ocWWKKJstCe4atrh00/AHxX9ioXgq8Zm1Hxv1Vovu5dEgRHKKVjQHkZvLh2RF9CdfvPkFni6ar5wcAkFZcdyWbSbouw+Nw6GUi1bsSMDyvSnnY6dYmfX+wCU0dLg+SdH4bZGVc7Kvc54iKkFFyJ/S/H6boGKS7dIKpi106arWzMvJKQoMY40rQvCLHlvlWVmA7tTj7kgsNxakuEgzl0LvxQe3mLzhoXaQXVTqaYA2Morey9XqfJlnmxlSwecR2yVy4bCHtTxL4JIEHY5xZfPV1nko0/fkDupCvM7N0uAsHe7/Lbyo0+Qt2b+ptnUDKmUwydZaAPUF/l2Mk27g34O28IbUSMtDIjjQlYZsSIi4KSe7CzORGiulcrzjVSG0DYO4irQaHKKLRe/Jm3Wt95fMKfJb+kUy7y3ayw+8vqiXG6Wg2h5s1yG6xZJ9oSO6M3hxzahTf9hqkuy6lamLH36IYaiE+Wb15bPorl5qWQOYcuim13UZCCU5EPq4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RSt4cXVlc2tVc2JacEVWUFhadE9SYnp6VXZxcS80QzdUK0lWTFE0dk02UFh5?=
 =?utf-8?B?OFNLVzhaZEluUy9XNXU1T1BocDcyKzFGNi9RUjQrN2sxc2hUemYrdFR3UjZy?=
 =?utf-8?B?NHRaYnZxbWN3eUIrWUhkVEc1V2pMbDN3aDNqYUlDR0JyVkd3YmZISmRvNmJz?=
 =?utf-8?B?Nm1NZjJUN2pRY0w1eUQ2dlVjSElKaU1ncmkwNGhzeUVGTmhna1Y4TzdRUitl?=
 =?utf-8?B?N0R0Y0JJTDlEMXlrUTRsWXkvSmNtK0RxVFhRbUZGSnRCaHVPZTZtdGhwN2Rx?=
 =?utf-8?B?RDdVek5KdndNOXRpUVRQS29zYnQvUlFaUGRMWXAwcUVHV2p5dnhwK2VXbDJK?=
 =?utf-8?B?RG9GZXNYZ0RLRFE1SllpWjJMaVBPZGd3QVZyYzhEOVRoc2FnSThlYlZwKzYx?=
 =?utf-8?B?aVBGbm9KTnZVcm43NER4aWtreUtzQ3BiaVg3TklLd2t3Wm1HYnBnbG9EemRm?=
 =?utf-8?B?bkFRb291OEpMVCtoVEJ1d3RIeXRja2tVMGZneFN1bkpETW8zRHFVWGFIWlZU?=
 =?utf-8?B?QkEvV0VJTm1wS1BGZTZpR2pvNGozL0Jvdnh1WU12cUNGV0VtVmxaR0djSFBv?=
 =?utf-8?B?UjJvb0grMEs0K2lnelNOQzU4ajFmVmRoUnRyeWRldzlEOXZRSmplTVQwMWRt?=
 =?utf-8?B?dnJ1eW9rN2tHVU1KT1dXQ2hUOWZyaEFIUENPR3NMSnFMQkVOVTQyZzRlNHI5?=
 =?utf-8?B?V1czaDFIaEJNWVNDSC96OE5CWGhheld3OFVpQldsbld6SjN4bFRiQkUrb0VM?=
 =?utf-8?B?RERiR3JHaHl6UzFFQ2VFQTlZWTl2U05RM3J1UXYyZy9MMS9tUE9jdG5TK1ow?=
 =?utf-8?B?RmZqVUJ4YjhlQTZHTDdTZEdEYS90c3BTNWlzbEJyL3NId0VtMlNEWkp6dWFr?=
 =?utf-8?B?VEhRZlRQWkUyaEw2RjNQWkV4NGpvdWhIUEdXNWhURk5OMVR4a3ZjS3Fnc2dj?=
 =?utf-8?B?MG1FYzVTVm9TWlZjSXFva2NjU3IwMzNodTJBUDR5QmJuNzdiWW5FU2NtNGlT?=
 =?utf-8?B?VDdSUkZvRUREMENzM1NkTTVQT0dibFNiZW5yWElNS2ZockxnSEV3MjRPVEdq?=
 =?utf-8?B?bmUxb1R3ZmUzTGd3R1FTV3BsQTJySUpZSzBaSWVpSys5eXdpNmpha2VMZFZG?=
 =?utf-8?B?dXlaQmtuRUx5aG53TlFleXBidUlmVHMrVE5jTUhkWkR1NjFNSFM2NzBRV2Vj?=
 =?utf-8?B?aGxLNkVjRytERVFwVExielB0ZC9icHJadnJIb29wSUdsV0RCWVRtL3I2Wmtj?=
 =?utf-8?B?K1UydlZueVFMRGtONTlVd1ZBZktTcHd1MTJidHNIaWt6ck9ET0s4ZTBFZEZD?=
 =?utf-8?B?ajBNWnZ0TGpDVUtuQ1kzM21YT0ZuMm9IRUlCc2s4WDFleWgrS0doRU52Snpv?=
 =?utf-8?B?SGdrTGVXcUxUc1JTZ2pYQjMyUi9TWllHOVNJVTgwZ0NjelF5SXd0VWZTdXJQ?=
 =?utf-8?B?MUlFMU5raE5KaEhNZm43ZkcrQUxUWER1ZW9SNEZ0QXVaMXVHSFNoYm1tN3N6?=
 =?utf-8?B?aExiMHlsTXRRRkhJOGNyMzdVWXNXK0QrSUxFWm9KR0lId2tnYVk0NFZ6V2ph?=
 =?utf-8?B?TWUydm5kWW1GajFTSkdLRThXWmJ6cC8rUFh3b0pjS2FmY1RNdHM1WjcwSWxw?=
 =?utf-8?B?YVN1UmU1Rm5XWDlXaW9uQ0ZVb00vMG9kYi9GYzU2MUkzOXcwSkMzRmpseWl6?=
 =?utf-8?B?MjljaUhGalpsMGxMdUQyamZRQnRTUFJnNS9nZ01SYVNaMng0OXVONGhwNzlr?=
 =?utf-8?B?cHlBdVlHMzNOeStTUCtleU1xcTdxRXJRQzczb1hrbGZmWm9ZcktFQXlRM2tu?=
 =?utf-8?B?TlFYaDdUYVBrUWJrMXJFZis1WDJoQUhQcXp1YkNENTlNcktiWjdEVWg4TU9P?=
 =?utf-8?B?bzc4akxITjYwMVc4Vk5uelQ4VTQ5bGd6eTlQbEtBQmt2eXBHL0Y1WHdpWThW?=
 =?utf-8?B?UUNvZFA3d2xwZzNVZWRjWm43OFJSTnN6R2hIV0JscC82MXlLaC94REJnRDRq?=
 =?utf-8?B?SWtBNy9WSVkrT2U1bFRDbEwyQWhRb21HcG54S1JzMHZ0d2NsUnhhRWVTTUpy?=
 =?utf-8?B?NDVocmtQeFdDTHRSMHN1ZTBpY1d5K3lPdEZIVFpUTWNKWHA1WCszREtlci9R?=
 =?utf-8?B?MnM2UFcrdXdZd29BbEdlenFnQ3U1OElLTmhHVUlSNUhzWXRNaDJFaGVrTDc5?=
 =?utf-8?B?SkdtM3RRRjVNUnZUQVE2b1ExTDVmbnRXcVJocElpMkFkcFpSeGtPcGI2SzZs?=
 =?utf-8?B?U2RqbEFKbGpIRUR1ckVSdkY5R0FRdENrSUlxYTR4cE9nQU1TcnUrU1IvWlBV?=
 =?utf-8?B?Z2FHVWVDZC9LVlNiM2VocVUwTWFjQ2wxd1dTd1ExOGIzVm91WXVDLzRldnJD?=
 =?utf-8?Q?502Wk24CVfzml2Ry6WK+924bfBh6wjSe5Ey4ywiOV3jmc?=
X-MS-Exchange-AntiSpam-MessageData-1: pmgjc6Eqq+4lSA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de56228f-fd35-4c79-b450-08dea743e073
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 05:38:30.5030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIvmaNGlr0mVyljwu8jCkWYIoxRAkbV6mUutqf1ctrBq6cly4NzITSeWxs6M1gFs3DIt661ZpmyKYDN+Jyxu3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7431
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

On Wed Apr 29, 2026 at 10:35 PM JST, Alexandre Courbot wrote:
> On Tue Apr 21, 2026 at 5:20 PM JST, Eliot Courtney wrote:
>> If `header.token_size` is smaller than `BitToken`, then we currently can
>> read past the end of `image.base.data`. Check that the token size is at
>> least as big as `BitToken`.
>>
>> Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU =
table in FWSEC")
>> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/vbios.rs | 34 +++++++++++++++++-----------------
>>  1 file changed, 17 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbio=
s.rs
>> index 6de7e58e0da0..de856000de23 100644
>> --- a/drivers/gpu/nova-core/vbios.rs
>> +++ b/drivers/gpu/nova-core/vbios.rs
>> @@ -423,31 +423,31 @@ impl BitToken {
>>      /// Find a BIT token entry by BIT ID in a PciAtBiosImage
>>      fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
>>          let header =3D &image.bit_header;
>> +        let entry_size =3D usize::from(header.token_size);
>> +
>> +        if entry_size < size_of::<BitToken>() {
>> +            return Err(EINVAL);
>> +        }
>
> You can get rid of this check if you convert the code as suggested
> below.
>
>> =20
>>          // Offset to the first token entry
>>          let tokens_start =3D image.bit_offset + usize::from(header.head=
er_size);
>> =20
>>          for i in 0..usize::from(header.token_entries) {
>> -            let entry_offset =3D tokens_start + (i * usize::from(header=
.token_size));
>> -
>> -            // Make sure we don't go out of bounds
>> -            if entry_offset + usize::from(header.token_size) > image.ba=
se.data.len() {
>> -                return Err(EINVAL);
>> -            }
>> +            let entry_offset =3D tokens_start + (i * entry_size);
>
> Should we use checked arithmetic here?
>
>> +            let entry =3D image
>> +                .base
>> +                .data
>> +                .get(entry_offset..)
>> +                .and_then(|data| data.get(..entry_size))
>> +                .ok_or(EINVAL)?;
>> =20
>>              // Check if this token has the requested ID
>> -            if image.base.data[entry_offset] =3D=3D token_id {
>> +            if entry[0] =3D=3D token_id {
>>                  return Ok(BitToken {
>> -                    id: image.base.data[entry_offset],
>> -                    data_version: image.base.data[entry_offset + 1],
>> -                    data_size: u16::from_le_bytes([
>> -                        image.base.data[entry_offset + 2],
>> -                        image.base.data[entry_offset + 3],
>> -                    ]),
>> -                    data_offset: u16::from_le_bytes([
>> -                        image.base.data[entry_offset + 4],
>> -                        image.base.data[entry_offset + 5],
>> -                    ]),
>> +                    id: entry[0],
>> +                    data_version: entry[1],
>> +                    data_size: u16::from_le_bytes([entry[2], entry[3]])=
,
>> +                    data_offset: u16::from_le_bytes([entry[4], entry[5]=
]),
>
> A common pattern in this file (with several such sites still to fix), is
> that since Nova only supports little-endian we can leverage `FromBytes`
> in order to avoid all these `from_le_bytes` call. Here this would look
> as follows:
>
>     for i in 0..usize::from(header.token_entries) {
>         let entry_offset =3D i
>             .checked_mul(entry_size)
>             .and_then(|off| tokens_start.checked_add(off))
>             .ok_or(EINVAL)?;
>
>         let entry =3D image
>             .base
>             .data
>             .get(entry_offset..entry_offset + entry_size)
>             .and_then(|data| data.get(..entry_size))
>             .ok_or(EINVAL)?;
>
>         let (token, _) =3D BitToken::from_bytes_copy_prefix(entry).ok_or(=
EINVAL)?;
>
>         if token.id =3D=3D token_id {
>             return Ok(token);
>         }
>     }
>
> which has several benefits:
>
> - No error-prone `entry[index]` accesses,
> - The size check on `entry_size` is done for free by
>   `from_bytes_copy_prefix`, and the slice bounds cannot be wrong,
> - Shorter, more readable code overall.
>
> Unfortunately we cannot just use `from_bytes_prefix` because we don't
> have any alignment guarantee, but this is still an improvement IMHO.
>
> If you go that way and derive `FromBytes` on `BitToken`, don't forget to
> also make it `#[repr(C)]`. :)

I agree this is better, thanks!
