Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBFDFD5F85
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 07:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E3F10E545;
	Wed,  8 Apr 2026 07:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KQCXwdtw";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F010410E545
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 07:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpproW+B8ErbJuqVxqsWHmtHEaaODDOvIP2V43ULJJVd3luuFpa1gpJBI+XderI1hybBBTWhJuaTIOlUP5w3nAm9PpzTNN9Ytscd71woO8yK4H+kfe40HUmN5g5dJRzsoElTAIr5NfMqVeb7XmH/jBQcuRR6Oi9YECCAhTEP5merjy4aqhmkkDcpg1JfQa0tP+9QiN6Fnm3I9iBXg09wHsjokfvqdrAQ7c97gO1OXX+17XVRTvk90V+UyMnysrattyunB9TjCUo8j1EJ/PadbpsyEx2DTUxLd4bodXwcBGZQ/LKaz8JaL/Id08kBdD+AnOyE8Xi0+7QP5Gbd85sGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQcPJ5my52Z/Si9B+PKzFUPU/XFyuwbwUsXaghPfwog=;
 b=LVg/1bxmuiHCNnthyKuKmZURfj6gJlv3epfEnK3scjL9daTWoZDODDAawLLHYNmD/C/NH2mEm1IrZv6z/0Ducj+3EqfZ1YmjwuvoM5DRUpyPLGhR9GNcKGgs35f9eXcAHJpMewERonw6vsilhaXER3SxEibVJkmlmEQDd/XgRxgFpOreHdfvWJ7YZjVkoVbiV3Uezg3WgsNFP5v/0rSjmIec33A6BraEeiKrRadY/Wigbme9J5F9fFyGO1N1pivOT0dIhOKz30p4hD5bEV5dws3aGcRSbBXrRaj8uiaiXaZK9EyGHy4KZFbQ9hobQYDbxLZCSW4Jlq9qAP7E+3GaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQcPJ5my52Z/Si9B+PKzFUPU/XFyuwbwUsXaghPfwog=;
 b=KQCXwdtw9gVs/F8oAKi8w9Bjq+cD5Bc1xQtoA7R6bCa4Fdra66puWD6Hn2+6VAZxeJHJsnPrGM1xiMPaq1e+IuqDGcWQ+7R7HjQAreQfKCHbEMc8jSwo1XDFDzE157YvyFfLTItGgSYzTPekTT6yuF99F5WotkqTCrTL0HTNcCu87DMT9/l/JiTCLSHF4DnYz197c6IHtHl27BVsbwGhzNKQTuiWo+L0CAX9sPoUA6dt4jKHbICL7/KACSaZRgk8yN2lm+OqgB4YlVtLUM/vsQFyWb2YEljot5x8ut8O3zHkLGZAq4FEoNmKGUL0bUwsZu5SANeLf5WIdvuiGsQ/bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 07:12:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9769.018; Wed, 8 Apr 2026
 07:12:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 16:12:06 +0900
Message-Id: <DHNL4LO606IT.3BG7X9RVSKZHD@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova: require little endian
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260407-fix-kconfig-v2-1-6b4fb06c690c@nvidia.com>
In-Reply-To: <20260407-fix-kconfig-v2-1-6b4fb06c690c@nvidia.com>
X-ClientProxiedBy: TYXPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:403:a::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dced04b-ea6e-44ed-11b4-08de953e2698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: z6DFNQTVUO2YnhPfYv2LQx4L3K6yl5eol19M6K9vKHWxlfTIzRVcRAtrB3GWUip22irqlp23jJqOqJjs6XgHBv0V8LRVhJHQLGVqWV2WEBlYKoXn6E9S768+L4P7EHj6nlbfl3UuWCT+hmNNvu0eUFrPip4E6uRIrF+Qop5fBmp79YqY/EBMqhetNUbTNT3yU6ux+gwVpzUWiWAL88o+nbdoee9Ar7k4GtF1YIhMJv3i2T+9itJ5iLE4WkuMInwaAv6ZTmTCE+rp4oKdnMKBcFa8YmOg7pjRcEUKR5JSCNSzMieezFs3+dO6TySJjc64FYg6OHay2azvwe2y1byy1uvvQiQAlE7TZDJ7yFAkfUMlStZzLV64PGoC8ohp3lujgPDl8QOSLOeH7FiGbg7SeH9RAB76yTndVqjjHCceDoHna3T7o+eWA96OIkHLRbGTXxw5hAEz/6CeN7MM8+gwyC/Xo9Hv+MsrrfpFFFESx8jdaJuLU8cBSXpl27Hx4eJbcCnv407DbesjFKfU84FrD0dPYYCEyXYxBxpAhIP6eFgtgaY41Cb9nIAq0+9l4AFczivs2hoIoL9srZ6/6quiIG/w9nyDJBWv+7Ke0ZTCI5VrjJMgBDjlozupLPADMjq7uAYY5dfi9zaPuJoRNrdrL+wT4485r5w+5EkVJE051FCtWKJL2WB30LmquMuTChIhqtsYItPavQDdn50l6mVh5dqjWLBPq+NEhaKsJf6hjjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHM1aEhmaWJ3eG1HQ0U0ejR5MUtxZi80NVRkMm5kS0VNRTBibDdycXBxOU1N?=
 =?utf-8?B?djNSZkduNVFOYXhaU3p5ZElEbC9mQmM3UVdqUjN2S3E0SGpjeDExZDI1dlA1?=
 =?utf-8?B?eTRTWUF2cFdEbHpOdndQRlF1cGdKNk1NYXlWMzhZd3RLRVM1WHk0ZzNZR2FS?=
 =?utf-8?B?d3JTWnY1Slc1eTdYbkEyMlNCMmFUUFBNZlFLV3d6b3JFOHRYWDEvaFUyL2ZS?=
 =?utf-8?B?ZGVZakF5UzRFNUVCNnh3djNVdlVlL21rbHFRUzQvdFl3TFdieGRzSlFMOWZN?=
 =?utf-8?B?L2pRU3ptK1huVXlJRDVld3pRLy9xSGhvS3pLZ2lmYkF5dzJGdWoxcU5EaUl0?=
 =?utf-8?B?MGt2TXcyUjVkaFB6c2hrbm1TWEhMcjgvQjk4UHhSbFN6VlpiaHFkNXlQcFo0?=
 =?utf-8?B?cFhVNXkvc2paYjNPTG1KTThoenV1TGQzTHBIRVY3UmxXRTVCck10T0M1Wkpw?=
 =?utf-8?B?SzR5MkFpbk1JTDBBbEdDVlVHRTBvWGNCVUc2UEhiTlFJRm9BcDZ3eUdMR0xs?=
 =?utf-8?B?ZWdhMnBMRFdkaWhjZ0dLYTVIdkFwOXFWelo0WiswU2drUVJSY1I2V2k5bGFN?=
 =?utf-8?B?bE9SRVJqUWIxNXQ5SVV4WHFjaE5pMENPVnJ2bWdlbzluWWtYU3FCNEtDbGwv?=
 =?utf-8?B?d0xub3JwVjQ3ODRDSzQvZEZTZ0NKNHBxOTdtSlNoTnRpOFU4YzZYYll5Q09O?=
 =?utf-8?B?T3VjdFBqNXB6T3YyWElLTUltMHFKdjA2S0IxeWx0Z0p1VHhMeFNoVTE5YUpP?=
 =?utf-8?B?ZnZPUEozSXpmUE9EM1FVUHBmL2k4ekh4UHd4OWVpNlRnaS8yR3ljWDlEY2hZ?=
 =?utf-8?B?b3lLamJFUEF4eVFPRHNUMHpPUGxKdzJ4OXB3YTRPb1JiaHllZ2pRczNHbzdn?=
 =?utf-8?B?cnNNQTNnaTAyN2hQS1VTeEJta3ZQdG9jeXBFYVk1b3pvMENkTGZ6UmhuN0Ja?=
 =?utf-8?B?V2NycTg5V0Faa1BUV2ZnWkRVSm1hM1hDbjBLZERnQmVQN2tGS1FLNTlSNjBE?=
 =?utf-8?B?dExyY016MUt6SE9CaWFsSFUzTnR1cFdJYzZJcmduOUF6MUlCY3YyK2ZHWTVv?=
 =?utf-8?B?STcxUEJyamFjQTNrVWYrNFRGOHVVMmtYTmx2RXRaZVUxbFdUT041ZW93K2hK?=
 =?utf-8?B?bHVNNWlrdExkendSNFhwazRRSkNnZGtaRGtWeG55cFBjTS92ZksxdDBTMGVt?=
 =?utf-8?B?RUNXQzdKWVE3UjhPYmRQcE1oTFA1dTBJaWs3ZEg4RnJnbi85WUVkWlo5UjFI?=
 =?utf-8?B?TjJELzl2QjRnWUpwT3gvNUJ3TXcxSXlDb05wNk1UcmozckNYUEU0VWxQTHhG?=
 =?utf-8?B?MDhVUWJ1REdlV0ZEQ3NoNTE5bURvdVpoUTJOUnZncFhJZis2NXo2SkwrcDFi?=
 =?utf-8?B?VEF3amQrb1kvYXhUSDg5V3NPMGpQd1hiazFPWWN3cXFzMEJXMnJoZURTbi9D?=
 =?utf-8?B?TGUrcjdqMWxWZGZHYkZDVlM4QjFrWXZXbmNoSjdKdm5FNWM0RjJydzR3aDRJ?=
 =?utf-8?B?eFUwYTZSeStGSVc0NVpVNUVYUFpmL1Z4K2RMbk9ZNjlITi91TGwvbXNxeGQ4?=
 =?utf-8?B?Tk9TR3kxNkRvc0NsMjdmY0hzZXhxT2tPS0ZMSVFwT0xxTDZxd1ZkMHp6RlZk?=
 =?utf-8?B?VEdPdkUvaVJtRzNIWlMxUndVNGpZM2lJRnZzYUJweG5NTHVXbTM0U3pQZzIy?=
 =?utf-8?B?b1Jwd2ZZcHlsMVMzajFlWTVvM3VidGgwb0M2S21mL2s3VnV6SmtMYlB5aTlQ?=
 =?utf-8?B?Rmk1TWhIYVoya1FCVHIwaGl3YXUzbzFHY0VYZC9HaVU5UXJtK21ZbithVWtE?=
 =?utf-8?B?RURxTExIUzQrck1MbXpPWDlwUWg0T1RZNytvRVluM0kvTWcvUUIySUZZdytX?=
 =?utf-8?B?QmdrYXNPT3l0YWh5K3hRQ1Q4UUNGNVpGQ0lCMGRwYVJlUmlaU0FiYTVkMzBp?=
 =?utf-8?B?djMzQ1ZZMFBMaHpkZUZwdFN3WmRqRE5pMlBCd005clBQWlhDUmFuNWRKUnp2?=
 =?utf-8?B?YjRqOW1YSWd5WEpGQm9Sbmd2QzRNVHJ3OXpUc2YxTngyaEhHQ3Y0bGlpbUI4?=
 =?utf-8?B?STVzVElTcnJlUWhsRzZrdG9ac0ZiR00xbEtqbHNGY1FudlQ0ajNPcnNXcDNi?=
 =?utf-8?B?RHhPQmM5bitJVGt5SUFXT3ZwSEt3TWRvNW9wVlBvcHlGQ3QwK1Qxck4rS3NW?=
 =?utf-8?B?RGNrR1FZd053QitRVFFYc2wyNWVQZHgyK2JLa2t0SGpiaHZvOUdwWUVvd2Fu?=
 =?utf-8?B?aHYrQVNxVElxOEx3dWZ2dWJKQjhCbmtsSnc5clB1OEEweXlKekhrRnRGajhn?=
 =?utf-8?B?ZE1jL0dzY2NSMEJhU0xQWG5ESDlXNk5VMWRzYm1xUEFBaWFZcUZVWUxLbTNF?=
 =?utf-8?Q?BptAv3plTdJM/ox3LlAZV3OOWsTzsJf3NyX2lJxhYFIlM?=
X-MS-Exchange-AntiSpam-MessageData-1: uWjtt+RZ4ujjPg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dced04b-ea6e-44ed-11b4-08de953e2698
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 07:12:10.4094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1xv8trO9ogOxSgrhVjBwaSIRXiSJPnKN0edH0+thHLmlCM1R6WxfOOweomTxnCcZMZOBp7bHLceyMePS4cwaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
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

On Tue Apr 7, 2026 at 12:59 PM JST, Eliot Courtney wrote:
> The driver already assumes little endian in a lot of locations. For
> example, all the code that reads RPCs out of the command queue just
> directly interprets the bytes.
>
> Make this explicit in Kconfig.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Letting Danilo pick that one as he mentioned.
