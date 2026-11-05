Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40A606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sRnoCY4r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A1A1122A5;
	Thu,  5 Nov 2026 09:45:41 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 357111122A5;
 Thu,  5 Nov 2026 09:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMqBnKKlJ7MN+dmJhOdaILqnBsAyFfk+d4j3b7SyYY6ppmTF5Wf+pJil1kbV+EdtopNpXxHNnVHIelCBRYlqPdd/n7RP+91duPJAS7A5IBl1aQLeKoSPbsk96k5dLJH34hivp+WRZJdO9QCdNm9TAKBkqSPTjaxRlnLQqHSHhqxtnsCQd31ydvv7Gp4mw9tGvKSFZCCIagJAXkzydkJd+ovyeuMz2cXH2Ks/s4J26gYIgSD/QnRBj56xh0cWYmh+FD0h/Ye5vKrpjWGBP5p2fSbyUwFmTYC+tOP7X0cpCHTobnsHqqkvgFx/9EZGuEqDJH8FY7r+kTQdq1LSqehm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hbK6wCpuCBOmGjg6B2UwtWz3vOD0L6DonBne2c+UhA=;
 b=HNM30an7v70mEIdMiG/hPszY1X9MYoyXXTfU9vQ7y2kXik7u/doB6LDw9zLpR4RLlSO1SXr8mZcLDbeLJ/sjaFXCB0fqGt9m6CHY6baoBNglfDZZUM9w+teqjTikpInANudMu1tRCApNzCm1hCF7r6PI3PQWnv1C0hyNMnJNPAw6NBLVNLKBpnGKqzO/PfliJPstWITV1PO5OGTPhLXttOAnqp+z718ZCH5EWPlMJqfU9HDTXIiGcIjQpn8cu/AKWhqyhrMQbuDWm310SUaTVtVU5ODkhkh/SVtNI80H5edzYEyQp0ZC3GHma+JD0sXs5u6ejtCz0FP7hBo5FWyXyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hbK6wCpuCBOmGjg6B2UwtWz3vOD0L6DonBne2c+UhA=;
 b=sRnoCY4rtcd8smrtIVLIhQ2fH5vDWVOsA2dwB4iDb7Eo6sKQaiRRPG4JYO/Bo1DAlP9HHQxRKLdNtvZhC1Eu9PjQY8ix0flmE3e/CRgbSg/CbLzL+N2oYm2ABvvXnsq3f/poXo+BqYOlIYMnodThB5/fm3fMFU22s6F3SN+CRFQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11) by SJ0PR12MB6784.namprd12.prod.outlook.com
 (2603:10b6:a03:44f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 09:45:32 +0000
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585]) by CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 09:45:32 +0000
Content-Type: multipart/mixed; boundary="------------sfRYh1nBCTHjHtXwbwis4swf"
Message-ID: <930da65c-67de-4d05-9734-deb58d8981ff@amd.com>
Date: Thu, 5 Nov 2026 17:45:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Don't require DMUB PSR caps before DCN
 3.0
To: Hugo Sales <hugo@hsal.es>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Chenyu Chen <chen-yu.chen@amd.com>, Alex Hung <alex.hung@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261029171219.2842014-1-hugo@hsal.es>
 <3f79f22f-a8e9-4fd4-ab78-2403d38b1292@amd.com>
 <313360626.451345.1793787476448@app.mailbox.org>
Content-Language: en-US
From: Ray Wu <ray.wu@amd.com>
In-Reply-To: <313360626.451345.1793787476448@app.mailbox.org>
X-ClientProxiedBy: TP0P295CA0049.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::20) To CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999225:EE_|SJ0PR12MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 101b9465-0887-452e-0e75-08df3b21887a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|6049299003|23010399003|1800799024|376014|366016|261022105027099003|261009223027099003|261028144727099003|261026140227099003|4143699003|11063799006|18002099003|22082099003|4053099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: VbjMnE9CRNM7fUT/I/ucSZPLDI0+kjSbttKY78NiSjxAjzEMWJ75kYDsROG+U8l/QQKsUfzRr4kDpHqevnsHQ6H9IrF/cEI37fFblubfU2P7YHZWeMKI17DY6UqSIX35GLuUf4BeFmeikIgXgxXWmgbupwYpzQ+TvABDladgsPA9MsqtuBnRkUajW11lcqb3DttpesY7F7bhVf+ybOlpM3tvl8q2B+EbrwaGVjxpc/MlFHCaX1WISofZ528v7ucwrbQm2Y0vZNtiPD73KUFqTd4qUdNPGX2Ni+Rgwc/A5kZv4JJq77X3ziqudFtfLFw2JB1nYxXWX0MSsSYegjIRDI4oQEcmJrNWZUPWs9ErJY51v2TNgfkHLwjOkDSmrvLbDiH1eNiLDzLOjo9Gx+NyRcFP937N54WA1Cls5CRKvJP3LHjkfJN8KSfQTUlW2BwqmCFwKZkRw1hHT0D7MTNV2OPLoqw8RsTgs/mh4GKSolqud3Z10OOfMiQ2vm+hOIVBHSM5wEl7uX6lWw1IMAE7WyyGndtuhF0e5WDLek8KkmRDD5oSdioLvnpcoOTCeu6HU6UPofBErb9y9JdZ8l+TiUe/Dse57w/D7n1zZLpp6vyfRlxXrsO26L7lWKzBlukg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999225.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(6049299003)(23010399003)(1800799024)(376014)(366016)(261022105027099003)(261009223027099003)(261028144727099003)(261026140227099003)(4143699003)(11063799006)(18002099003)(22082099003)(4053099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFBTRHU1UEdHM0duODFwZEV1OWZCMzJULzJJdnU1WEZibXcwbEZPSUFJOEov?=
 =?utf-8?B?R0NLRDRkeVNTa2dQZHBvNTFhV1o1QVp0QmhPS0F6U05Bb05vUFc5S2U5eVB4?=
 =?utf-8?B?WVhpeDJLbTAxb0IvbUVWUHFaY1NaMmxTM1NScmlicVU4cXZORGR0UjlRV1c1?=
 =?utf-8?B?bkF6TzZNUmg3TXBUdXpKRnU4V2ptTE9XUTcva1d6SFV1WEowTENuNmludGhi?=
 =?utf-8?B?dVFKQWk4bHB3ekRWS1hocnNHWGhPc245ZGVTbWpCc1NmZ1I0WC9JR2d6QlZk?=
 =?utf-8?B?U282cEFydFYwRU1sVzhNTTVOZEJ0Z2d3NnVFV2M0YVk5dDVWb0NCa2ZSVmhn?=
 =?utf-8?B?eHp3RHdoWXRtTWVvQm4wUkc2VmdTZmxBQlgzM0IwajRtbDRJck9OYVdQQ2Nr?=
 =?utf-8?B?bmhwb01Ob3pMWkNkVithcFNYdFNhL05BZEJDdTNObGVQYWlkVmwwbmsyUGtH?=
 =?utf-8?B?ZjNpT0RmMUQ1SUZmblJOdmV5V1dCbmpOMUpueVZaVmhLQ0RnS3JaSDNBNklY?=
 =?utf-8?B?RXZZdEdJbXVEVmhkMXJNQ2lVd3dhQy9TWU81ZEFCVHJKL2xOd3hVTVFPSU56?=
 =?utf-8?B?M3FKajhON3lQMmR6aVJqRTkxVkRSWjh4bFRLblpIL1p6cnhQQzUxUFdwVWJa?=
 =?utf-8?B?MmtqZVRPcW1LVnZYYzJQT1VYWkl2SVJ4aWZjWW1IR1E4Y0J3VVl2MGoxRXNk?=
 =?utf-8?B?bXVzOXUzV3pBV3FSWnIzTzZic1dDRnZTSmxFcXpXWStxRmZjS056aTdROVhw?=
 =?utf-8?B?SXJ4Qm9RYlp3bm9nWlFqRzkyVGRyM2k4dVVuaDRjU2daQUtrck9kNmRDMGdD?=
 =?utf-8?B?ZnVvVmx6b0pEWGVaWllGdENHQVRJRlJrVnNQaDdRUVdNVUFmOWdYcm5sQTV5?=
 =?utf-8?B?Y3Frdlo2SjJPYmp2aHlzT1prUnQ1Q1YwV0xLNlovN3lQS2ozTDhJWjdYZEpD?=
 =?utf-8?B?S2M4OGRTNHNIaktJdzJ3Nkk5MnlsZ0V5azRaaVQ0ZElidnIyZlJRZE5iM3Q2?=
 =?utf-8?B?bURyOGdGTXdHckpRQUFhTjBQdUtYR1ZXaW8zRlNuOUJJdFhBdUJ4R0xDbDR3?=
 =?utf-8?B?cVk5ZU52RTkvajZFM3UyVWxyS0I1SEFKNFRqVWFqRldDZnUyTGY2dUNxRm5E?=
 =?utf-8?B?VWN4bkJDSzJiWVZQWDVuWmcvbEs1clFTcUMyOXpPQlQwYlpHejkrbmtZOXgx?=
 =?utf-8?B?OEdDdENSRk1MTGJqcUxwV1FheExtaHM1dGN5TkRrVzVxVHVuYkE0QkZ6akdF?=
 =?utf-8?B?S3lBUHRYL1d6QzZnajNTK1pBWHJZN2dMVUtpbUREdklERkdPZTROMkp0TW9s?=
 =?utf-8?B?MTNsdUpZUkhqRUMxaTlLL1QwNGY5RWdFbGJPY3NpQ05OcHkyWDVCU1ZYdktC?=
 =?utf-8?B?RGtibDkwVW9adFlnTi9SSHkyNU8vWHdRTTlkdzB3NDVBdUI2RGFmSVRlakcv?=
 =?utf-8?B?bkVoWmw0Wldqc1FFS1pJQWxadDR3czQ3bWl3NVA2R3J1a2VyV0R2U0hDVWdW?=
 =?utf-8?B?ZTIrVFF5bW44Uys2RlZPVzdqMXNiR0RkdE9GZnpWQ212c2NaemZSUHVlRXJp?=
 =?utf-8?B?UlJnMjlwTGpidGRGOEsyeVNZcXpST3UxVU1nNzZWUjlJekdnUXpLK2pKL0VF?=
 =?utf-8?B?SmlyRS9HemRncU5RRnB5dlJrUDU0MUp2TklRNGsreGZNM2lpemRzNUpaa0Fx?=
 =?utf-8?B?Y0MvZnZ6azcvRGhWbzJVd29kdWF5Z0o3Uk9hb3FNejJNSytnZzVZdVhZNUVS?=
 =?utf-8?B?VkJnb2tIVURTVnhvQ2YwL25wS0JENWhVS3dUM3BzVnMrMWNSUlR4VmNjYnh0?=
 =?utf-8?B?bGdTbXFHZ1lVOFlZdDZlSzU4T2k4V1dCUHA0QkpvTUYvS1ZkQXNQTkJHZXFN?=
 =?utf-8?B?c0o3QStnYklBcE5zRmRLU3J3N0ZSKzQ3TTN6Nm0yVEMreHh2cUsxL3hnVEZq?=
 =?utf-8?B?b3M3eUFWOWtnOEpqeENjSlcraGpmMEZrMUpXclpzK0Q0S3NTUDV0UFdzT0li?=
 =?utf-8?B?T2ZNcnRGc1p1Y1ZFV200MXBZd21XazNwbWlROUVTY0libVpIVHBsZlRQVncz?=
 =?utf-8?B?UUxucVZ0bmp4eEJuakJianZrZUlISGp3MWM1R3EvTDFHL0dLcjc5YmozVGJR?=
 =?utf-8?B?V2FiYm0rQVdvS084ekplWGZkL3V1bmgxajdKVlhXTC9nZ3kzYkJvN3pueG0v?=
 =?utf-8?B?akdwdUdaakJEUE14VG1QQ2R3VHJkRExsQ2xTNnYwRTZYQi9pY2xiREtzaUJU?=
 =?utf-8?B?c1M5UHF4NWhTUDgwNExiV2w2aVoxdm1kTjl6d2Q0OWMvTVhBUWl4WkVmTFp0?=
 =?utf-8?B?OFMxdHJKZXNySG45NFFYMVBkcmZQVkF5YkV2aVUzY2dOd09MM3QwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101b9465-0887-452e-0e75-08df3b21887a
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999225.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 09:45:32.0695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jlCGrtfNAojrKgJnITKKoFji65s8pn8of9o8frbKJaSJcUODRB/KceHUcuqVB8CBuXMwqQ+4zPhAZY/eyckVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6784
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------sfRYh1nBCTHjHtXwbwis4swf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hugo,

Thanks. I've attached the patch here.

There's also a related discussion here:
https://gitlab.freedesktop.org/drm/amd/-/work_items/5993

Please give it a try and let me know if it resolves the issue.
If so, I'll add your Tested-by.

Thanks,
Ray

On 11/4/2026 6:17 PM, Hugo Sales wrote:
> On 11/04/2026 9:31 AM WET Ray Wu <ray.wu@amd.com> wrote:
>> We already have a similar fix internally that is planned for an upcoming DC release:
>>
>> commit: drm/amd/display: Allow DC_PSR_MASK to enable PSR without DMUB PSR cap
>>
>> Could you give it a try and see if it resolves the issue?
> Hi Ray,
>
> Happy to test it, but I can't find that commit. It isn't on amd-gfx and
> it isn't in amd-staging-drm-next yet. Could you post it to the list, or
> send it to me directly?
>
> I'll try it on my ROG Flow X13 (DCN 2.1) with PSR. Since my patch reported the same problem, could the commit also carry a
> Reported-by/Tested-by for me?
>
> Thanks,
> Hugo
--------------sfRYh1nBCTHjHtXwbwis4swf
Content-Type: text/plain; charset=UTF-8; name="test-5993-dm-psr-gate.patch"
Content-Disposition: attachment; filename="test-5993-dm-psr-gate.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtX3Bzci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVf
ZG1fcHNyLmMKaW5kZXggZGJhZDBhNmQzYTJiLi4yOTViMWMzMDdmYTMgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3Bzci5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3Bzci5jCkBA
IC0xMTEsNyArMTExLDggQEAgYm9vbCBhbWRncHVfZG1fc2V0X3Bzcl9jYXBzKHN0cnVjdCBkY19s
aW5rICpsaW5rLCBzdHJ1Y3QgYW1kZ3B1X2RtX2Nvbm5lY3RvciAqYWMKIAkvKiBSZXNldCBwc3Ig
dmVyc2lvbiBmaXJzdCAqLwogCWxpbmstPnBzcl9zZXR0aW5ncy5wc3JfdmVyc2lvbiA9IERDX1BT
Ul9WRVJTSU9OX1VOU1VQUE9SVEVEOwogCi0JaWYgKCFkYy0+Y2Fwcy5kbXViX2NhcHMucHNyKQor
CS8qIERDTiBJUHMgdGhhdCBuZXZlciBxdWVyeSBETVVCIGZlYXR1cmUgY2FwcyByZWx5IG9uIERD
X1BTUl9NQVNLIHRvIG9wdCBpbiAqLworCWlmICghZGMtPmNhcHMuZG11Yl9jYXBzLnBzciAmJiAh
KGFtZGdwdV9kY19mZWF0dXJlX21hc2sgJiBEQ19QU1JfTUFTSykpCiAJCXJldHVybiBmYWxzZTsK
IAogCWlmICghKGxpbmstPmNvbm5lY3Rvcl9zaWduYWwgJiBTSUdOQUxfVFlQRV9FRFApKQo=

--------------sfRYh1nBCTHjHtXwbwis4swf--
